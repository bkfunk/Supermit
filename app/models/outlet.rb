class Outlet < ActiveRecord::Base
  attr_accessible :title, :url, :desc, :type, :genres, :submit_method, :submit_open_date, :submit_close_date
  
  has_and_belongs_to_many :submissions
  
  validates :title, :presence => true
end
