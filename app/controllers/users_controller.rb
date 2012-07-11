class UsersController < ApplicationController

  def index
    @tickets_assigned = Ticket.find(:all, :conditions => {:assigned_to => current_user.id })
  end

  def show
    @user = User.find(params[:id])
  end

end
