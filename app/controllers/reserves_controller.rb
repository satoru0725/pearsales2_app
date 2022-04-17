class ReservesController < ApplicationController
  
  before_action :permit_params, except: :new

	def new
		@reserve = Reserve.new
	end

	def back
		@reserve = Reserve.new(@attr)
		render :new
	end

	def confirm
		@cart_items = current_cart.cart_items.includes([:product])
    @total = @cart_items.inject(0) { |sum, item| sum + item.sum_of_price }
		@reserve = Reserve.new(@attr)
		if @reserve.invalid?
			render :new
		end
	end

	def complete
		Reserve.create!(@attr)
	end

	private

	def permit_params
		@attr = params.require('reserve').permit(:id, :reserve_on, :remark).merge(cart_id: current_cart.id)
	end

end
