class Heroku::SsoController < ApplicationController

  before_filter :authenticated, :request_valid

  def create
    cookies["heroku-nav-data"] = params['nav-data']
    session[:heroku_sso] = true
    session[:current_account_id] = @account.id
    redirect_to dashboard_url
  end

  protected

  def authenticated
    @account = Account.find_by_id(params[:id])
    render status: 404, text: "404 Not Found" unless @account
  end

  def request_valid
    render status: :forbidden, text: "403 Forbidden" unless token_valid? && timestamp_valid?
  end

  def token_valid?
   pre_token = params[:id] + ':' + 'pkYwAWyk5qoBHxPx' + ':' + params[:timestamp]
   token = Digest::SHA1.hexdigest(pre_token).to_s
   token == params[:token]
  end

  def timestamp_valid?
    params[:timestamp].to_i >= (Time.now - 2*60).to_i
  end
end
