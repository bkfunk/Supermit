class Piece < ActiveRecord::Base
  attr_accessible :user_id, :title, :genre, :desc
  
  belongs_to :user
  
  has_many :submissions, :dependent => :destroy
end
