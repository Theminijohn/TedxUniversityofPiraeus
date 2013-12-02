class Application < ActiveRecord::Base
	
  belongs_to :user

  validates :first_name, :presence => true
  validates :last_name, :presence => true
  validates :phone, :presence => true
  validates :email, :presence => true
  validates :concept, :presence => true
  validates :tell_us, :presence => true
  validates :cvq, :presence => true
end
