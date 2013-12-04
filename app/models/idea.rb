class Idea < ActiveRecord::Base
  belongs_to :user

  validates :full_name, :presence => true
  validates :email, :presence => true, :uniqueness => true
  validates :title, :presence => true
  validates :body, :presence => true

end
