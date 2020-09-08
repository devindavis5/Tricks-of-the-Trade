class CreateFavoritedStocks < ActiveRecord::Migration[5.2]
  def change
    create_table :favorited_stocks do | t | 
      t.integer :user_id
      t.integer :stock_id
    end
  end
end
