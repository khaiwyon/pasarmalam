class OrdersController < ApplicationController

  def new
    @order = Order.new
  end

  def create
    @total_price = 0.0
    @ordercontent = JSON.parse(cookies[:cart])
    @ordercontent.each do |k,v|
      item = Item.friendly.find(k)
      item_total = 0
      item_total = item.price * v.to_f
      @total_price += item_total
    end

    @order = Order.create(price: @total_price, user_id: current_user.id)
    if @order.save
      @bill = Billplz.create_bill_for(@order)
      @order.update_attributes(bill_id: @bill.parsed_response['id'], bill_url: @bill.parsed_response['url'])
      #@bill.parsed_response['id'] / @bill['id']is the same thing
      cookies.delete(:cart)
      redirect_to @bill.parsed_response['url']
    else
      render :new
    end
  end
end
