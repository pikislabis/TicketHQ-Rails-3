# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

if User.all.blank?
	user = User.create(:name => 'Administrador', :email => 'tickethq.rails@gmail.com', :login => 'admin', :password => 'administrador', :password_confirmation => 'administrador', :admin => true)
	user.enabled = true
	user.save
end
