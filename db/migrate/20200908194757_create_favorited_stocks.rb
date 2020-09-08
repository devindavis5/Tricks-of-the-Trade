class CreateFavoritedStocks < ActiveRecord::Migration[5.2]
  def change
    create_table :favorited_stocks do | t | 
      t.integer :stock_id
      t.integer :user_id
    end
  end
end
