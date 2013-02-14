class TodosController < ApplicationController
  before_filter :restrict_access
  before_filter :authorized, except: [:index, :create]

  def index
    render json: @account.todos 
  end

  def show
    render json: @todo
  end

  def create
    @todo = Todo.new(params[:todo]) 
    @todo.account = @account
    @todo.save
    render json: @todo
  end

  def update
    @todo.update_attributes(params[:todo])
    render json: @todo
  end

  def destroy
    @todo.destroy
    render json: {message: "OK"}
  end

  protected
  def restrict_access
    authenticate_or_request_with_http_token do |token, options|
      @account = Account.find_by_token(token)
      puts @account.inspect
      (@account && @account.id.to_s == params[:account_id])
    end
  end

  def account
    puts request.headers.inspect
    @account ||= Account.find_by_token(request.headers[:token])
  end

  def authorized
    @todo = @account.todos.find_by_id(params[:id])
    unless @todo
      render status: 404, json: {message: "404 Not Found"}
    end
  end
end
