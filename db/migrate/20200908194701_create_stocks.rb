class CreateStocks < ActiveRecord::Migration[5.2]
  def change
    create_table :stocks do | t | 
      t.string :name
      t.string :industry
      t.integer :dividend
      t.integer :cost
    end
  end
end
