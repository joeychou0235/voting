class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # exception handling
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  private
  def record_not_found
    render plain: " 查無資料", status:404
  end
end
