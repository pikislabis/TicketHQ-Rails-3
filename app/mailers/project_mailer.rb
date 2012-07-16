class ProjectMailer < ActionMailer::Base
  default from: "info@tickethq.com"
  
  def ticket_create(user, ticket)
    @ticket = ticket
    @url    = "#{APP_CONFIG[:site_url]}/tickets/#{ticket.id}"
    @user   = user 
    mail(:to => user.email, :subject => "[#{APP_CONFIG[:site_name]}] Nuevo ticket")
	end

end
