require 'httparty'

class TodoAPITest

  include HTTParty

  base_uri 'http://localhost:3000/accounts/11/todos'
  format :json

  def self.access_token
    "f1525ef2b18248fcf9f5bbd9f46eb2e6"
  end

  def self.headers
    {"Authorization"=>"Token token=\"#{access_token}\""}
  end

  def test_create
    options = { :body=> {todo:{:text => "test test #{Time.now.to_i}" }}, headers: self.class.headers}
    response = self.class.post('', options)
    puts "Create returned : "
    puts response.parsed_response.inspect
  end

  def test_index
    response = self.class.get('', headers: self.class.headers)
    puts "Indx returned : "
    puts response.parsed_response.inspect
  end

  def test_show
    response = self.class.get('/3', headers: self.class.headers)
    puts "Show returned : "
    puts response.parsed_response.inspect
  end

  def test_destroy
    response = self.class.delete('/3', headers: self.class.headers)
    puts "Destroy returned : "
    puts response.parsed_response.inspect
  end

  def test_update
    options = { :body=> {todo:{:text => "updated #{Time.now.to_i}" }}, headers: self.class.headers}
    response = self.class.put('/11', options)
    puts "update returned : "
    puts response.parsed_response.inspect
  end
end

todo_api = TodoAPITest.new
todo_api.test_index
todo_api.test_create
todo_api.test_show
todo_api.test_destroy
todo_api.test_update
