class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
  
  after_initialize :default_user_role
  
  def default_user_role
    self.role = :standard    
  end
  
  enum role: [:admin, :standard, :premium]       
  
end
