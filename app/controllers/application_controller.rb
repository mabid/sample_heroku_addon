class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_account

  private

  def current_account
    @current_account ||= Account.find_by_id(session[:current_account_id])
    render status: :forbidden, text: "403 Forbidden" unless @current_account
    @current_account
  end
end
