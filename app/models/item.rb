class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :delivery_cost
  belongs_to :sender
  belongs_to :delivery_date
  has_one_attached :image

  belongs_to :user
end