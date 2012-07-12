# -*- coding: utf-8 -*-

class TicketsController < ApplicationController
 
  before_filter :find_ticket, :only => [:show, :edit, :update, :destroy]

  def index
    if current_user.admin?
      @tickets = Ticket.find(:all)
    else
			@tickets = Project.proyectos(current_user,"view").map {|x| x.tickets}
      @tickets.flatten!
	  	@tickets.uniq!
    end
    if @tickets.length == 0
      flash[:error] = "No hay tickets para los proyectos vinculados."
      redirect_to :back
    end

    #TODO: paginate
		#@tickets = @tickets.paginate(:page => params[:page], :per_page => 10)
  end
  
  def new
    if !current_user.admin and Project.proyectos(current_user,"make").length == 0
		  flash[:error] = "El usuario no tiene privilegios para crear tickets en ningun proyecto."
		  redirect_to :back
		elsif !params[:project_id].blank? and !Project.proyectos(current_user,"make").include? Project.find(params[:project_id])
		  flash[:error] = "El usuario no tiene privilegios para crear tickets en el proyecto."
		  redirect_to :back
		end  
		@ticket = Ticket.new
		@projects = current_user.admin ? Project.all(:conditions => {:closed => false}) : Project.proyectos(current_user,"make")
		if !params[:project_id].blank?
		  @project = Project.find(params[:project_id])
		  @ticket.project_id = params[:project_id]
		end  
		6.times {@ticket.labels.build}
  end

  def create
    if !params[:file].blank? and params[:file].size > 3.megabytes
      flash[:error] = "El archivo no puede ser mayor de 3MB."
      render :action => "edit"
    end 
    @projects = Project.proyectos(current_user,"make")
    @ticket = Ticket.new(params[:ticket])
    @ticket.status = Status.find(:first, :conditions => {:project_id => @ticket.project_id})
    @record = @ticket.records.build
    @record.text2 = "Ticket creado."
    @record.user = current_user
    if !params[:file].blank?
      @attach = @record.attaches.build
      @attach.file = params[:file]
    end
    if @ticket.valid?
      @ticket.save
      flash[:notice] = 'El ticket ha sido creado correctamente.'
      redirect_to(@ticket)
    else
      flash[:error] = 'Ha habido un error creando el ticket.'
      render :action => "new"
    end
  end
  
  def show
    
    #TODO: añadir nuevos ficheros al ticket
    
    # Tickets que se pueden ver
    tickets_view = Project.proyectos(current_user,"view").map{|x| x.tickets unless x.nil?}
    tickets_view.flatten!
    
    if !tickets_view.include? @ticket and !current_user.admin?
      flash[:error] = "No tiene privilegios para ver el ticket."
      redirect_back_or_default('/')
    end
    
		# Tickets que se pueden actualizar
		tickets_upgrade = Project.proyectos(current_user,"upgrade").map{|x| x.tickets unless x.nil?}
    tickets_upgrade.flatten!
    
		# Codigo para ver si tiene los privilegios para poder editar el ticket.
    if current_user.admin? or tickets_upgrade.include?(@ticket)
      @edit = true
    else
      @edit = false
    end
		
		# Tickets que se pueden borrar
		tickets_remove = Project.proyectos(current_user,"remove").map{|x| x.tickets unless x.nil?}
		tickets_remove.flatten!
	
		# Codigo para ver si tiene los privilegios para poder borrar el ticket.
		if current_user.admin? or tickets_remove.include?(@ticket) or @ticket.user == current_user
	  	@delete = true
		else
	  	@delete = false
		end

		#Usuarios con privilegios de visión para poder asignar el ticket
		@users = @ticket.users
		
		# TODO: paginate records
		# @records = Record.find(:all, :conditions => {:ticket_id => @ticket.id}).paginate(:page => params[:page], :per_page => 5)
		# @records = Record.where(:ticket_id => @ticket.id).paginate(:page => params[:page])
		@records = Record.where(:ticket_id => @ticket.id)
		
		@record = Record.new
		@record.attaches.build
		
		# TODO: paginate related_tickets
		# @related_tickets = @ticket.related_tickets.paginate(:page => params[:page])
		@related_tickets = @ticket.related_tickets
		
  end
 
  # Realizamos la consulta según los datos introducidos. Para el titulo/descripción tendremos en cuenta cada palabra
  # introducida por separado, priorizando aquellos tickets en los que se encuentren todas las palabras introducidas.
	def advanced_search
	  
	  #TODO: cambio de estados al cambiar proyecto
	  #TODO: mostrar/ocultar tickets cerrados
	  #TODO: modificar link_to_remote
	  
		@projects = Project.proyectos(current_user,"view")
		@users = @projects.map{|p| p.users}.flatten.uniq
		if params[:q].nil?
		  @statuses = Array.new
		else
		  @statuses = params[:q][:project_id].blank? ? Array.new : Project.find(params[:q][:project_id]).statuses
		end
		@q = Ticket.search(params[:q])
		@tickets = @q.result(:distinct => true)
		#TODO: paginate
		#@tickets = @tickets.paginate(:page => params[:page], :per_page => 10)
	end
  
  def toogle_observe
	  ticket = Ticket.find(params[:ticket_id])
	  if current_user.ticket_subs.include?(ticket)
	    current_user.ticket_subs.delete(ticket)
	    flash[:notice] = "Se ha dejado de observar el ticket."
	  else
	    current_user.ticket_subs << ticket
	    flash[:notice] = "Se esta observando el ticket."
	  end
	  redirect_to ticket_path(ticket)
	end
  
  def related_tickets
	  @ticket = Ticket.find(params[:ticket_id])
	  @projects = Project.proyectos(current_user,"view")
	  if params[:search].nil?
		  @statuses = Array.new
		else
		  @statuses = params[:search][:project_id].blank? ? Array.new : Project.find(params[:search][:project_id]).statuses
		end
		#TODO: cambiar search
		@q = Ticket.search(params[:q])
		@tickets = @q.result(:distinct => true) - [@ticket]
		#TODO: paginate
		#@tickets = @tickets.paginate(:page => params[:page], :per_page => 10)
	end
  
  def toogle_closed_tickets
  end
  
  def mod_rel_tickets
	  @ticket = Ticket.find(params[:ticket_id])
	  @ticket_o = Ticket.find(params[:ticket_o_id])
	  
	  if params[:type] == 'add'
	    ticket_rel = TicketRelationship.new
	    ticket_rel.ticket = @ticket
	    ticket_rel.ticket_o = @ticket_o
	    ticket_rel.user_id = current_user.id
	    ticket_rel.save  
	  elsif params[:type] == 'del'
	    ticket_rel_1 = TicketRelationship.find(:first, :conditions => {:ticket_id => params[:ticket_id], :ticket_o_id => params[:ticket_o_id]})
	    ticket_rel_2 = TicketRelationship.find(:first, :conditions => {:ticket_id => params[:ticket_o_id], :ticket_o_id => params[:ticket_id]})
	    
	    ticket_rel_1.nil? ? '' : ticket_rel_1.delete
	    ticket_rel_2.nil? ? '' : ticket_rel_2.delete

	  end  
	  
	  redirect_to ticket_related_tickets_path(@ticket)
	  
	end
  
  private
    
    def find_ticket
      @ticket = Ticket.find(params[:id])
    end

end
