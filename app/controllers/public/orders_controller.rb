class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!
  before_action :cart_items_exist, only: [:new]
  before_action :is_matching_login_customer, only: [:show]

  def new
    @order = Order.new
  end

  def confirm
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @order.shipping_fee = 800
    if params[:order][:select_address] == "0"
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.last_name + current_customer.first_name
    else
      @order.postal_code = params[:order][:postal_code]
      @order.address = params[:order][:address]
      @order.name = params[:order][:name]
    end
    @cart_items = current_customer.cart_items
    render :confirm
  end

  def complete
  end

  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @order.shipping_fee = 800
    @order.save

    current_customer.cart_items.each do |cart_item|
      @order_detail = OrderDetail.new
      @order_detail.item_id = cart_item.item_id
      @order_detail.order_id = @order.id
      @order_detail.price = cart_item.item.with_tax_price
      @order_detail.amount = cart_item.amount
      @order_detail.save
    end

    current_customer.cart_items.destroy_all
    redirect_to "/orders/complete"
  end

  def index
    @orders = current_customer.orders.order(created_at: :desc)
  end

  def show
    @order = Order.find(params[:id])
  end

  private

  def order_params
    params.require(:order).permit(:postal_code, :address, :name, :payment_method, :total_payment)
  end

  def cart_items_exist
    cart_items = current_customer.cart_items
    unless cart_items.exists?
      redirect_to "/cart_items"
    end
  end

  def is_matching_login_customer
    order = Order.find(params[:id])
    unless order.customer_id == current_customer.id
      redirect_to "/customers/my_page"
    end
  end

end
