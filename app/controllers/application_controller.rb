class ApplicationController < ActionController::Base
  before_action :authenticate_admin!, if: :admin_url
  before_action :authenticate_customer!, unless: :item_url

  def admin_url
    request.fullpath.include?("/admin")
  end
  
  def item_url
    request.fullpath.include?("/items")
  end
end
