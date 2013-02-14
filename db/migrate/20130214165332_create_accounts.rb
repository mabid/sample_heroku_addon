class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string :name
      t.string :plan
      t.string :heroku_id

      t.timestamps
    end
  end
end
