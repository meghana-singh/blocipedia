class Wiki < ActiveRecord::Base
  has_many :collaborators
  has_many :users, through: :collaborators
  
  belongs_to :user
  #scope :publicly_visible , -> {where(private: false)}
  
  def owner
    self.user
  end
  
  def publicly_visible? 
    true if self.private == false 
  end
  
end
