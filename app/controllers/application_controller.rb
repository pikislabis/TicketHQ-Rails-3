# -*- coding: utf-8 -*-

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery
  
  before_filter :authenticate_user!, :user_setup, :values, :prepare_for_mobile
  
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
  
    def mobile_device?
    	if session[:mobile_param]
    		session[:mobile_param] == "1"
    	else
    		request.user_agent =~ /Mobile|webOS/
    	end
    end
    
    helper_method :mobile_device?
    
    def prepare_for_mobile
      session[:mobile_param] = params[:mobile] if params[:mobile]
    	request.format  = :mobile if mobile_device?
    end  
  
  private
  
    def values
  		@type_state = [["Nuevo", false], ["Abierto", false], ["Resuelto", true], ["Reasignado", false]]
  		@type_priorities = ["Baja", "Media", "Alta"]
  		@type_origin = ["Manual", "e-mail"]
  	end

end
