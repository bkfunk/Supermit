class User < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :email
  
  validates :email, :presence => true,
                    :uniqueness => { :case_sensitive => false }
  
end
