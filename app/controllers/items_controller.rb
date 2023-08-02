class ItemsController < ApplicationController

  def index
    
  end

  def new
    authenticate_user!
    @item = Item.new
  end
  
  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private
  def item_params
    params.require(:item).permit(:item_name, :description, :category_id, :condition_id, :delivery_cost_id, :sender_id, :delivery_date_id, :price, :image).merge(user_id: current_user.id)
  end
end
