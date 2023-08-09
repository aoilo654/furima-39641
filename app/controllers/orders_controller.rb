class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item
  before_action :order_item
  
  def index
    @order_address = OrderAddress.new

    if current_user.id == @item.user_id
      redirect_to root_path
    end
  end

  def create
    @order_address = OrderAddress.new(order_params)
    if @order_address.valid?
      pay_item
      @order_address.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def order_params
    params.require(:order_address).permit(:postcode, :prefecture_id, :city, :block, :building, :phone_number).merge(user_id: current_user.id, item_id: params[:item_id], token: params[:token])
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

  def order_item
    if Order.exists?(item_id: params[:item_id])
      redirect_to root_path
    end
  end

  def pay_item
    binding.pry
    Payjp.api_key = "sk_test_769649f7b3254dc56fbabbd7"  # 自身のPAY.JPテスト秘密鍵を記述しましょう
    Payjp::Charge.create(
      amount: set_item[:price],  # 商品の値段
      card: order_params[:token],    # カードトークン
      currency: 'jpy'                 # 通貨の種類（日本円）
    )
  end
end
