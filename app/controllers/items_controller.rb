class ItemsController < ApplicationController
  def index
    @items =Item.limit(3).where(buyer_id: nil).order(created_at: :desc)
  end

  def new
    @item = Item.new
    @item.images.build
    @item.build_brand
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to action: "index"
    else
      render "new"

    end
  end

  def show
    @item   = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
    # binding.pry
  end

  def update
    item = Item.find(params[:id])
    item.update(update_params)
    redirect_to item_path(item.id)
  end

  def destroy
  end

  def buy
  end
  
  private
  def item_params
    params.require(:item).permit(:name, :text, :category_id, :damage_id, :fee_id, :area_id, :send_date_id, :price, images_attributes: [:image_url], brand_attributes: [:name]).merge(seller_id: current_user.id)
  end

  def update_params
    params.require(:item).permit(:name, :text, :category_id, :damage_id, :fee_id, :area_id, :send_date_id, :price, images_attributes: [:image_url, :_destroy, :id], brand_attributes: [:name]).merge(seller_id: current_user.id)
  end
end