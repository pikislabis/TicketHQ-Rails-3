# -*- coding: utf-8 -*-

class ProjectsController < ApplicationController
  
  before_filter :find_project, :only => [:show, :edit, :update, :destroy]
  
  def index
    @projects = project_user
  end
  
  def show
		#TODO: paginate
		#@tickets = @project.tickets.paginate(:page => params[:page], :per_page => 10)
		@tickets = @project.tickets
	end
  
  def toggle_observe
	  project = Project.find(params[:project_id])
	  if current_user.project_subs.include?(project)
	    current_user.project_subs.delete(project)
	    flash[:notice] = "Se ha dejado de observar el proyecto."
	  else
	    current_user.project_subs << project
	    flash[:notice] = "Se está observando el proyecto."
	  end
	  redirect_to project_path(project)
	end
  
	private
	  def find_project
	    @project = Project.find(params[:id])
    end
    
    def project_user
      projects = Array.new
      if current_user.admin?
        projects = Project.find(:all)
      else
        current_user.groups.each do |x|
          projects << x.projects
        end
      end
      projects.flatten!
      projects.uniq!
      projects
    end  
  
end
