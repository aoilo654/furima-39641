class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :delivery_cost
  belongs_to :sender
  belongs_to :delivery_date
  has_one_attached :image

  belongs_to :user

  validates :item_name, :text, presence: true
  validates :description, :text, presence: true
  validates :price, presence: true, format: { with: /\A[0-9]+\z/, message: "is invalid. Input half-width characters" }
  validates :price, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999 }

  validates :category_id, :text, numericality: { other_than: 1 , message: "can't be blank"}
  validates :condition_id, :text, numericality: { other_than: 1 , message: "can't be blank"}
  validates :delivery_cost_id, :text, numericality: { other_than: 1 , message: "can't be blank"}
  validates :sender_id, :text, numericality: { other_than: 1 , message: "can't be blank"}
  validates :delivery_date_id, :text, numericality: { other_than: 1 , message: "can't be blank"}
end