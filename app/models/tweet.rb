class Tweet < ApplicationRecord
  belongs_to :user
  has_many :comments
  
  validates_presence_of :image, :text, :user_id
end
