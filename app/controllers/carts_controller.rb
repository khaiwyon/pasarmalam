class CartsController < ApplicationController
  # before_action :authenticate!, only: [:show, :remove_item, :update_item]
  # before_action :warning, only: [:add_item]
  before_action :load_cart
  after_action :write_cart, only: [:add_item, :remove_item, :update_item]

  def show
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

  def add_item
    if @cart[params[:id]]
      quantity = params[:quantity].to_i
      quantityOld = @cart[params[:id]].to_i
      @cart[params[:id]] = quantityOld + quantity
      redirect_to items_path
      flash[:success] = "You've added a ticket"
    else
      @cart[params[:id]] = params[:quantity]
      redirect_to items_path
      flash[:success]= "You've added a ticket"
    end
  end

  def update_item
    if @cart[params[:id]]
      @cart[params[:id]] = params[:quantity]
    end
    redirect_to cart_path
  end


  def remove_item
    @cart.delete params[:id]
    redirect_to cart_path
  end

  def load_cart
    if cookies[:cart]
      @cart = JSON.parse(cookies[:cart])
    else
      @cart = {}
    end
  end

  def write_cart
    cookies[:cart] = JSON.generate(@cart)
  end

  def warning
    if current_user
    else
      flash[:danger] = " You must be logged in to add items to cart!"
      redirect_to new_session_path
    end
  end
end
