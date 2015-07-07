class Article < ActiveRecord::Base
  belongs_to :user

  acts_as_votable

  validates :title, :body, presence: true
end
