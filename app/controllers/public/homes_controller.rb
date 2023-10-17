class Public::HomesController < ApplicationController
  def top
    @customers = Customer.all.order(created_at: :desc)
    @customers_first = @customers.first(2)
  end

  def about
  end
end
