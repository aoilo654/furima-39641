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
      @order_address.save
      redirect_to root_path
    else
      render :index, status: :unprocessable_entity
    end
  end

  private

  def order_params
    params.require(:order_address).permit(:postcode, :prefecture_id, :city, :block, :building, :phone_number).merge(user_id: current_user.id,item_id: params[:item_id])
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

  def order_item
    if Order.exists?(item_id: params[:item_id])
      redirect_to root_path
    end
  end
end
