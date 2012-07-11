class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :authenticate_user!, :user_setup, :values
  
  protected
  
    def user_setup
      if user_signed_in?
        if current_user.enabled
          User.current_user = current_user
        else
          sign_out current_user
          redirect_to login_path, :notice => 'Your account has be disabled. Please contact the administrator.'
        end    
      end
    end
  
  private
  
    def values
  		@type_state = ["Nuevo", "Abierto", "Resuelto", "Reasignado"]
  		@type_priorities = ["Baja", "Media", "Alta"]
  		@type_origin = ["Manual", "e-mail"]
  	end

end
