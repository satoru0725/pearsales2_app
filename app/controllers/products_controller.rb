class ProductsController < ApplicationController
  before_action :move_to_index, except: [:index, :show]
  def index
    @products_index = Product.all.order(created_at: :desc).includes(:user)
  end

  def new
    @form = Form::ProductCollection.new
  end

  def create
    @form = Form::ProductCollection.new(product_collection_params)
    if @form.save
      redirect_to user_path(current_user.id)
    else
      render :new
    end
  end

  def show
    @product = Product.find(params[:id])
  end

  def edit
    @user = User.find(params[:user_id])
    @product = Product.find(params[:id])
  end

  def update
    @user = User.find(params[:user_id])
    @product = Product.find(params[:id])
    if @product.update(product_params)
      redirect_to user_path(params[:user_id])
    else
      render :edit
    end
  end

  def destroy
    product = Product.find(params[:id])
    if product.destroy
      redirect_to user_path(params[:user_id])
    else
      render :show
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

  def product_params
    params.require(:product).permit(:name, :variety, :rank, :weight, :price, :stock, :postage, :remark, :suspended).merge(user_id: current_user.id)
  end
end
