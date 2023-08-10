require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  before do
    user = FactoryBot.create(:user)
    item = FactoryBot.create(:item)
    @order_address = FactoryBot.build(:order_address, user_id: user.id, item_id: item.id)
    sleep(1)
  end
  
  describe '商品購入' do
    context '商品購入できる場合' do
      it "すべての情報があればに購入できる" do
        expect(@order_address).to be_valid
      end
      it "buildingが空でも購入できる" do
        @order_address.building = ''
        expect(@order_address).to be_valid
      end
    end

    context '商品できない場合' do
      it "tokenが空では購入できない" do
        @order_address.token = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Token can't be blank")
      end

      it "postcodeが空では購入できない" do
        @order_address.postcode = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Postcode can't be blank")
      end
      it "postcodeがハイフンがないと購入できない" do
        @order_address.postcode = '12345678'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Postcode is invalid. Enter it as follows (e.g. 123-4567)")
      end
      it "postcodeが全角では購入できない" do
        @order_address.postcode = '１２３－４５６７'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Postcode is invalid. Enter it as follows (e.g. 123-4567)")
      end
      it "postcodeが文字列では購入できない" do
        @order_address.postcode = 'abc-defg'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Postcode is invalid. Enter it as follows (e.g. 123-4567)")
      end
      it "postcodeが8桁未満では購入できない" do
        @order_address.postcode = '123-456'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Postcode is invalid. Enter it as follows (e.g. 123-4567)")
      end
      it "postcodeが3桁ハイフン4桁以外では購入できない" do
        @order_address.postcode = '12-34567'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Postcode is invalid. Enter it as follows (e.g. 123-4567)")
      end

      it "prefecture_idが1では購入できない" do
        @order_address.prefecture_id = 1
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Prefecture can't be blank")
      end

      it "cityが空では購入できない" do
        @order_address.city = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("City can't be blank")
      end

      it "blockが空では購入できない" do
        @order_address.block = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Block can't be blank")
      end

      it "phone_numberが空では登録できない" do
        @order_address.phone_number = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone number can't be blank")
      end
      it "phone_numberが全角では登録できない" do
        @order_address.phone_number = '０９０１２３４５６７８'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone number is invalid. Input only number")
      end
      it "phone_numberが文字列では登録できない" do
        @order_address.phone_number = 'abcdefghijk'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone number is invalid. Input only number")
      end
      it "phone_numberが10桁未満では登録できない" do
        @order_address.phone_number = '123456789'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone number is too short")
      end
      it "phone_numberが12桁以上では登録できない" do
        @order_address.phone_number = '123456789012'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone number is too short")
      end
      
      it 'userが紐付いていなければ投稿できない' do
        @order_address.user_id = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("User can't be blank")
      end

      it 'itemが紐付いていなければ投稿できない' do
        @order_address.item_id = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Item can't be blank")
      end
    end
  end
end
