class User < ActiveRecord::Base
  
  include Gravtastic
  gravtastic
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable       

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :username, :name, :admin, :group_ids, :notification_preference
  cattr_accessor :current_user
  
  validates :username, :uniqueness => true

  has_and_belongs_to_many :groups
  has_many :tickets
  has_many :ticket_subscribes
  has_many :ticket_subs, :through => :ticket_subscribes, :source => :ticket
	has_many :project_subscribes
	has_many :project_subs, :through => :project_subscribes, :source => :project

end
