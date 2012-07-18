# -*- coding: utf-8 -*-

class Admin::ProjectsController < AdminController
  def index
    #TODO: paginate
		#@projects = Project.find(:all).paginate(:page => params[:page], :per_page => 10)
		@projects = Project.all
	end
	
	def new
		@project = Project.new
		3.times {@project.statuses.build}
		#TODO: add_status_link. Estados configurables
	end

	def create
		@project = Project.new(params[:project])
		if params[:statuses] == "default"
	    @type_state.length.times {@project.statuses.build}
	    @project.statuses.each_with_index do |status, index|
	      status.name = @type_state[index][0]
	      status.close = @type_state[index][1]
				status.position = index + 1
	    end
	  end
		if @project && @project.valid?
		  @project.save
			flash[:notice] = "El proyecto se ha creado de forma satisfactoria."
			redirect_to admin_projects_path
		else
			flash[:error] = "Ha habido un error al crear el proyecto. "
			@project.errors.each do |key, value|
			  flash[:error] += "#{key.to_s.capitalize}: #{value.to_s}. "
			end
			render :action => 'new'
		end
	end
	
	def new_status
  end

end