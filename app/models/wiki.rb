class Wiki < ActiveRecord::Base
  belongs_to :user
  scope :publicly_visible , -> {where(private: false)}
end
