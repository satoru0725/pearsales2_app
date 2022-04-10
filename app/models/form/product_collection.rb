class Form::ProductCollection < Form::Base
  FORM_COUNT = 5
  attr_accessor :products, :user_id


  def initialize(attributes = {})
    super attributes
    self.products = FORM_COUNT.times.map { Product.new() } unless self.products.present?
  end

  def products_attributes=(attributes)
    self.products = attributes.map { |_, v| Product.new(v) }
  end

  def save
    products.map do |product|
      product.user_id = self.user_id
      product.save if product.name
    end
  end

  
end