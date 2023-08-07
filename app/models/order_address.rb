class OrderAddress
  include ActiveModel::Model
  attr_accessor :postalcode, :prefecture_id, :city, :block, :building, :phone_number, :user_id, :item_id

  with_options presence: true do
    validates :postcode, format:{with: \A\d{3}[-]?\d{4}\z, message: "is invalid. Enter it as follows (e.g. 123-4567)" }
    validates :city
    validates :block

    validates :phone_number,numericality: {only_integer: true, message: "is invalid. Input only number" }
    validates :phone_number,length: { minimum: 10, maximum: 11, message: "is too short" }
  
    validates :user_id
    validates :item_id
  end

  validates :prefecture_id, numericality: { other_than: 1 , message: "can't be blank"}
end