class CreateStocks < ActiveRecord::Migration[5.2]
  def change
    create_table :stocks do | t | 
      t.string :name
      t.string :symbol
      t.float :cost
      t.float :change
    end
  end
end
