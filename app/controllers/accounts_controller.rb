class AccountsController < ApplicationController

  before_filter :current_account

  def dashboard
  end
end
