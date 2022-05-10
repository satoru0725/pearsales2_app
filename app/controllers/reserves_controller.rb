class ReservesController < ApplicationController
  
  before_action :permit_params, except: :new

	def new
		@reserve = Reserve.new
		@addresses = Address.where(customer_id: current_customer.id)
		@cart_items = current_cart.cart_items.includes([:product])
		@total = @cart_items.inject(0) { |sum, item| sum + item.sum_of_price }
	end

	def back
		@reserve = Reserve.new(@attr)
		@addresses = Address.where(customer_id: current_customer.id)
		render :new
	end

	def confirm
		@reserve = Reserve.new(@attr)
		@cart_items = current_cart.cart_items.includes([:product])
    @total = @cart_items.inject(0) { |sum, item| sum + item.sum_of_price }
		@address = Address.find(params[:reserve][:address_id])
		if @reserve.invalid?
      render :new
    end
	end

	def complete
		@cart_items = current_cart.cart_items.includes([:product])
		@reserve = Reserve.new(@attr)
		if @reserve.save
			@cart_items.each do |item|
				order_item = OrderItem.new
				order_item.quantity = item.quantity
				order_item.price = item.product.price
				order_item.product_id = item.product_id
				order_item.reserve_id = @reserve.id
				order_item.save
			end
		else
			@reserve = Reserve.new(@attr)
			render :new
		end
	end

	private

	def permit_params
		@attr = params.require('reserve').permit(:reserve_on, :remark, :total_price, :address_id).merge(customer_id: current_customer.id)
	end

end
