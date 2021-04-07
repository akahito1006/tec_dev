class Article < ApplicationRecord
  
  belongs_to :user
  has_many :likes   , dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :images  , dependent: :destroy
  
end
