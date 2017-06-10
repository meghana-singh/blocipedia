class User < ActiveRecord::Base
  has_many :collaborators
  has_many :wikis, through: :collaborators
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
  
  # Removed comfirmable as there is some issue with sending emails on cloud9
  # Though the mails are sent, they are never recieved by gmail/yahoo
  before_save -> { skip_confirmation! }
  
  after_initialize :default_user_role
  
  def default_user_role
    self.role ||= :standard    
  end
  
  enum role: [:standard, :premium, :admin]       
  
    
 def downgrade
  self.role = 'standard'
  self.save

  # down here you can change all the users wikis to public
  # (we can access all the user's wikis by doing self.wikis)
  self.wikis.update_all(private: false)
  
 end
 
end
