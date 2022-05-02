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
		@cart_items = current_cart.cart_items.includes([:product])
    @total = @cart_items.inject(0) { |sum, item| sum + item.sum_of_price }
		@reserve = Reserve.new(@attr)
		@address = Address.find(params[:reserve][:address_id])
		if @reserve.invalid?
      render :new
    end
	end

	def complete
		Reserve.create!(@attr)
	end

	private

	def permit_params
		@attr = params.require('reserve').permit(:reserve_on, :remark, :total_price, :address_id).merge(customer_id: current_customer.id)
	end

end
