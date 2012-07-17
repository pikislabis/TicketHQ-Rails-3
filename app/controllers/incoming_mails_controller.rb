class IncomingMailsController < ApplicationController
  require 'mail'
  skip_before_filter :authenticate_user!, :user_setup
  
  def create
    message = Mail.new(params[:message])
    
    user = User.find_by_email(message.from) or return
    project_id, title = message.subject.scan(/\[(\d)\]\s([\w|\s]*)/).first
    
    begin
      project = Project.find(project_id)
    rescue ActiveRecord::RecordNotFound
      TicketMailer.wrong_mail(user).deliver
      return
    end
    
    user.groups.map{|x| 
      x.projects unless !x.make}.flatten.include?(project) ? nil : (TicketMailer.wrong_mail(user).deliver; 
                                                                    return)
    
    ticket = Ticket.create(:title => title, :description => message.body.decoded, :user => user,
                            :status => Project.find(project_id).statuses.first, :priority => "Media", 
                            :project => project)
                            
    record = ticket.records.create(:user => user, :text2 => "Ticket creado")
    if !message.attachments.blank?
     email.attachments.each do |attach|
       record.attaches.create(:file => attach)
     end
    end
    
    Rails.logger.log message.subject #print the subject to the logs
    Rails.logger.log message.body.decoded #print the decoded body to the logs
    Rails.logger.log message.attachments.first.inspect #inspect the first attachment

    # Do some other stuff with the mail message

    render :text => 'success', :status => 200 # a status of 404 would reject the mail
  end
end
