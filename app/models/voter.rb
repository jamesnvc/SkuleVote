class Voter < ActiveRecord::Base
  has_and_belongs_to_many :elections

  acts_as_authentic do |c|
     c.login_field = :sid
  end
  
end
