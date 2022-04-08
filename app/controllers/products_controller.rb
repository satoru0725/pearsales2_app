class ProductsController < ApplicationController
  before_action :move_to_index, except: [:index, :show]
  def index
    @products = Product.all.order(created_at: :desc).includes(:user)
  end

  def new
    @form = Form::ProductCollection.new
  end

  def create
    @form = Form::ProductCollection.new(product_collection_params)
    if @form.save
      redirect_to products_path
    else
      render :new
    end

  end

  private

  def move_to_index
    unless user_signed_in? || customer_signed_in?
      redirect_to action: :index
    end
  end

  def product_collection_params
    params.require(:form_product_collection)
    .permit(products_attributes: [:name, :variety, :rank, :weight, :price, :stock, :postage, :remark, :suspended]).merge(user_id: current_user.id)
  end
end
