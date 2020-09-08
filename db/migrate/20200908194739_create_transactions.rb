class CreateTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions do | t | 
      t.integer :user_id
      t.integer :stock_id
      t.integer :unit_cost
      t.integer :quantity
      t.time :time #data type? timestamp..adjust time to user-friendly format
    end
  end
end
