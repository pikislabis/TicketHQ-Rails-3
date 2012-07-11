class AdminController < ApplicationController
  
	before_filter :authorize_admin
  
  protected
		def authorize_admin
			if !current_user.admin?
				flash[:error] = "No tiene privilegios para realizar esta accion."	
				redirect_to("/")			
			end
		end
end
