class IncomingMailsController < ApplicationController
  require 'mail'
  skip_before_filter :authenticate_user!, :user_setup
  
  def create
    message = Mail.new(params[:message])

    user = User.find_by_email(message.from)
    
    if user.nil?
      render :text => 'error', :status => 404
      return
    end
    
    project_id, title = params[:subject].scan(/\[(\d*)\]\s+([\w|\s]*)/).first
    
    begin
      project = Project.find(project_id)
    rescue ActiveRecord::RecordNotFound
      TicketMailer.wrong_mail(user).deliver
      render :text => 'success', :status => 200
      return
    end
    
    user.groups.map{|x| 
      x.projects unless !x.make}.flatten.include?(project) ? nil : (TicketMailer.wrong_mail(user).deliver;
                                                                    render :text => 'success', :status => 200;
                                                                    return)
    
    if message.multipart?
      message.parts.each do |part|
    		header = part.content_type.to_s
    		if header.include? "multipart/alternative"
    		  part.parts.each do |part2|
    				header2 = part2.content_type.to_s
    				if header2.include? "text/plain"
    				  description = part2.body.decoded
    					break
    				end
    			end
    		elsif header.include? "text/plain"
    		  description = part.body.decoded
    			break
    		end
    	end
    else
    	description = email.body.decoded
    end
    
    ticket = Ticket.create(:title => title, :description => description, :user => user,
                            :status => Project.find(project_id).statuses.first, :priority => "Media", 
                            :project => project)
                            
    record = ticket.records.create(:user => user, :text2 => "Ticket creado")
    if !message.attachments.blank?
     email.attachments.each do |attach|
       record.attaches.create(:file => attach)
     end
    end

    # Do some other stuff with the mail message

    render :text => 'success', :status => 200 # a status of 404 would reject the mail
  end
end