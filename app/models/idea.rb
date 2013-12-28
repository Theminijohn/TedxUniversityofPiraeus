class Idea < ActiveRecord::Base
  belongs_to :user

  validates :full_name, :presence => true
  validates :email, :presence => true, :uniqueness => true
  validates :title, :presence => true
  validates :specs, :presence => true
  validates :body, :presence => true

  TITLE = :Student, :Teacher, :Partner, :Other
  SPECS = :Event, :Speaker, :Host, :Experience, :Other

end
