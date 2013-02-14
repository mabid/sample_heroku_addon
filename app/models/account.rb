class Account < ActiveRecord::Base
  validates :name, presence: true
  validates :plan, presence: true
  validates :heroku_id, presence: true

  before_create :generate_access_token

  def self.new_heroku_account(params)
    account = Account.new
    account.heroku_id = params[:heroku_id]
    account.plan = params[:plan]
    account.name = params[:heroku_id].gsub(' ','').gsub('/','').gsub('!','').gsub(',','').gsub('.','').gsub('@','-')
    account
  end

  has_many :todos

  def generate_access_token
    begin
      self.token = SecureRandom.hex
    end while self.class.exists?(token: token)
  end
end
