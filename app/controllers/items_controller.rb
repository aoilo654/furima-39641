class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_item, only:[:show, :edit, :update, :destroy]
  before_action :order_item, only:[:edit, :update]
  
  def index
    @items = Item.all.order("created_at DESC")
  end

  def new
    @item = Item.new
    authenticate_user!
  end
  
  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
    unless current_user.id == @item.user_id
      redirect_to action: :index
    end
  end

  def update
    if @item.update(item_params)
      redirect_to action: :show
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if current_user.id == @item.user_id
      @item.destroy
      redirect_to root_path
    end
  end

  private
  def item_params
    params.require(:item).permit(:item_name, :description, :category_id, :condition_id, :delivery_cost_id, :sender_id, :delivery_date_id, :price, :image).merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def order_item
    if Order.exists?(item_id: params[:id])
      redirect_to root_path
    end
  end
end
