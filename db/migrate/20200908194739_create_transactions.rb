class CreateTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions do | t | 
      t.integer :user_id
      t.integer :stock_id
      t.float :total
      t.time :time
    end
  end
end
