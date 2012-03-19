class Todo < ActiveRecord::Base
  attr_accessible :title, :desc, :parent_id, :due_at, :has_time_due, :completed_date
  
  belongs_to :user
  
  validates :title, :presence => true
  validates :user_id, :presence => true
end
