class Stock < ActiveRecord::Base
    has_many :transactions
end