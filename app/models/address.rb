class Address < ApplicationRecord
  belongs_to :order

  validates :postcode,presence: true, format:{with: \A\d{3}[-]?\d{4}\z}
  validates :city,presence: true
  validates :block,presence: true

  validates :phone_number,presence: true,numericality: {only_integer: true, message: "is invalid. Input only number" }
  validates :phone_number,length: { minimum: 10, maximum: 11, message: "is too short" }

  validates :prefecture_id, numericality: { other_than: 1 , message: "can't be blank"}
end
