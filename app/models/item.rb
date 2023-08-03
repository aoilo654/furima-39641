class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :delivery_cost
  belongs_to :sender
  belongs_to :delivery_date
  has_one_attached :image

  belongs_to :user
  
  validates :image, presence: true
  validates :item_name, presence: true, length: { maximum: 40 }
  validates :description, presence: true, length: { maximum: 1000 }
  
  validates :price, presence: true, numericality: { message: "is invalid. Input half-width characters" }
  validates :price, numericality: {only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999, message: "is out of setting range" }


  validates :category_id, numericality: { other_than: 1 , message: "can't be blank"}
  validates :condition_id, numericality: { other_than: 1 , message: "can't be blank"}
  validates :delivery_cost_id, numericality: { other_than: 1 , message: "can't be blank"}
  validates :sender_id, numericality: { other_than: 1 , message: "can't be blank"}
  validates :delivery_date_id, numericality: { other_than: 1 , message: "can't be blank"}
end