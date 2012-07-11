class ProjectsController < ApplicationController
  
  before_filter :find_project, :only => [:show, :edit, :update, :destroy]
  
  def index
  end
  
  def show
		#TODO: paginate
		#@tickets = @project.tickets.paginate(:page => params[:page], :per_page => 10)
		@tickets = @project.tickets
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
