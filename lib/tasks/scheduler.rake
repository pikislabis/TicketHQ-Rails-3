desc "Send daily notifications to the users."
task :daily_notification => :environment do
	User.where(:notification_preference => "daily").each do |user|
		TicketMailer.daily_notification(user).deliver
	end
	if Time.now.wday == 0 #weekly_notification
		User.where(:notification_preference => "weekly").each do |user|
			TicketMailer.weekly_notification(user).deliver
		end
	end
end