class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  
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
    @items = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
    unless current_user.id == @item.user_id
      redirect_to action: :index
    end
  end

  def update
    item = Item.find(params[:id])
    if item.update(item_params)
      redirect_to action: :show
    else
      render :show, status: :unprocessable_entity
    end
  end

  private
  def item_params
    params.require(:item).permit(:item_name, :description, :category_id, :condition_id, :delivery_cost_id, :sender_id, :delivery_date_id, :price, :image).merge(user_id: current_user.id)
  end
end
