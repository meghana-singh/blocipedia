class Wiki < ActiveRecord::Base
  has_many :collaborators
  has_many :users, through: :collaborators
  
  belongs_to :user
  
  after_initialize :set_defaults
  
  def set_defaults
    self.private  ||= false
  end
  
  #scope :publicly_visible , -> {where(private: false)}
  
  def owner
    self.user
  end
  
  def publicly_visible? 
    true if self.private == false 
  end
  
end
