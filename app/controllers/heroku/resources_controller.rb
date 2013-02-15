class Heroku::ResourcesController < ApplicationController

  before_filter :authenticate

  def create
    @account = Account.new_heroku_account(params[:resource])
    @account.save
    response = { 
      :id => @account.id,
      :config => {
        'TODOSADDON_URL' => account_todos_url(@account),
        'TODOSADDON_ACCESS_TOKEN' => @account.token
      },
      :message => 'Successfully installed Todos'
    }
      
    render json: response
  end

  def destroy
    @account = Account.find(params[:id])
    @account.destroy if @account
    render json: "ok"
  end

  def update
    @account = Account.find(params[:id])
    @account.update_attribute(:plan, params[:plan])
    response = { 
      :id => @account.id,
      :config => {
        'TODOSADDON_URL' => account_todos_url(@account),
        'TODOSADDON_ACCESS_TOKEN' => @account.token
      },
      :message => 'Successfully Updated Plan'
    }
      
    render json: response
  end

  protected

  def authenticate
    authenticate_or_request_with_http_basic do |username, password|
      username == "todosaddon" && password == "aW8s0wb0pvkHcfbe"
    end
  end

end
