class RegistrationsController < Devise::RegistrationsController
  
  def update
    method = "update_with_password"
    if resource.send(method, params[resource_name])
      redirect_to user_path(resource)
    else
      clean_up_passwords(resource)
      redirect_to edit_user_registration_path
    end
  end
  
end