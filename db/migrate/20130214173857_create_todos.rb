class CreateTodos < ActiveRecord::Migration
  def change
    create_table :todos do |t|
      t.string :text
      t.integer :account_id

      t.timestamps
    end
  end
end
