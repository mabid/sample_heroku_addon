class Todo < ActiveRecord::Base
  attr_accessible :text

  belongs_to :account
end
