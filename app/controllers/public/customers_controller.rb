class Public::CustomersController < ApplicationController
  def show
    @customer = current_customer
  end

  def edit
  end
  
  def update
  end
  
  def confirm_unsubscribe
  end
  
  def unsubscribe
    @customer = current_customer
    @customer.update(is_active: false)
    reset_session
    redirect_to root_path
  end
end
