class Admin::HomesController < ApplicationController

  def top
    @orders = Order.order(created_at: :desc).page(params[:page])
  end

end
