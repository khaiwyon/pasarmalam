class CheckoutController < ApplicationController
  before_action :warning, only: [:show]
  before_action :load_cart

  def show
    load_items_from_cart
    @token = Braintree::ClientToken.generate
  end

  def payment
    load_items_from_cart
    create_order_from_items

    result = Braintree::Transaction.sale(
      amount: @total_price,
      payment_method_nonce: params[:payment_method_nonce],
      options: {
        submit_for_settlement: true
      }
    )

    if result.success?
      order = Order.create do
        transaction_id = result.transaction.id
        amount = result.transaction.amount
        user_id = current_user&.id
        status = "pending"
      end
      @items.each { |item| order.ordered_items.create(item_id: item.id) }
      cookies.delete(:cart)

      flash[:success] = "We've received payment for your order. You'll receive your order soon"
      redirect_to root_path

    else

      flash[:danger] = "Error placing order, please try again"
      redirect_to checkout_path
    end
  end

  private
  def create_order_from_items
    # binding.pry
    @order = current_user.orders.build(amount: @total_price)

    @items.each do |item|
      @order.ordered_items.build(quantity: item.quantity, item_id: item.id)
    end
  end

  def load_cart
    if cookies[:cart]
      @cart = JSON.parse(cookies[:cart])
    else
      @cart = {}
    end
  end

  def load_items_from_cart
    @items = []
    @total_price = 0.0

    @cart.each do |k,v|
      item = Item.friendly.find(k)

      item_total = 0
      item_total = item.price * v.to_f
      @total_price += item_total

      item.define_singleton_method(:quantity) { v }
      item.define_singleton_method(:total) { item_total }
      @items << item
    end
  end

  def warning
    if current_user
    else
      flash[:danger] = "You need to login before checkout"
      redirect_to new_session_path
    end
  end

end
