class OrdersController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @order_address = OrderAddress.new
    @item = Item.find(params[:item_id])

    if current_user.id == @item.user_id
      redirect_to root_path
    end
  end

  def create
    @order_address = OrderAddress.new(order_params)
    @item = Item.find(params[:item_id])
    if @order_address.valid?
      @order_address.save
      redirect_to root_path
    else
      render :index, status: :unprocessable_entity
    end
  end

  private

  def order_params
    params.require(:order_address).permit(:postcode, :prefecture_id, :city, :block, :building, :phone_number).merge(user_id: current_user.id,item_id: :item_id)
  end
end
