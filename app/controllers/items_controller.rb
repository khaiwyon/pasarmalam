class ItemsController < ApplicationController

  def index
    if params[:search] && params[:search].present?
      @tickets = Item.search(params[:search])
    else
      @tickets = Item.all
    end
  end

  def show
    @ticket = Item.friendly.find(params[:id])
  end

  # def add
  #   @ticket = Item.friendly.find(params[:id])
  #
  #   if @item.save
  #     flash[:success] = "You've added a ticket"
  #   else
  #     flash[:danger] = @item.errors.full_messages
  #   end
  # end

end
