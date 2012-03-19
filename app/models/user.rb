class User < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :email, :identifier_url
  
  has_many :todos, :dependent => :destroy
  
  validates :email, :presence => true,
                    :uniqueness => { :case_sensitive => false }
  
end
