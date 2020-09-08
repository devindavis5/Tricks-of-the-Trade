User.destroy_all
Stock.destroy_all
Transaction.destroy_all
FavoritedStock.destroy_all

User.create(name: "Jeff Grove", email: "jgrove@gmail.com", password: "Locksmith32", balance: 305000.00)
User.create(name: "Don Drew", email: "ddrew4234@gmail.com", password: "justapiece10349", balance: 210000.00)
User.create(name: "Cassie Rivers", email: "casscass65@yahoo.com", password: "valleymountain88", balance: 150000.00)
User.create(name: "Andy Brind", email: "andytbrind@gmail.com", password: "rosie2002", balance: 200000.00)

Stock.create(name: "Facebook", industry: "Soial Media Advertising, Information Technology", cost: 271.16)
Stock.create(name: "Amazon", industry: "Cloud Computing, E-Commerce", cost: 3149.84)
Stock.create(name: "Tesla", industry: "Automotive, Energy Storage", cost: 330.21)
Stock.create(name: "Google", industry: "Internet Cloud Computing, Computer Software", cost: 1523.60)
Stock.create(name: "Starbucks", industry: "Retail Coffee", cost: 85.41)
Stock.create(name: "Apple", industry: "Computer Hardware & Software", cost: 112.82)

# JEFF'S TRANSACTIONS:

Transaction.create(user_id: User.find_by(name: "Jeff Grove").id, stock_id: Stock.find_by(name: "Tesla").id, unit_cost: Stock.find_by(name: "Tesla").cost, quantity: 50, time: Time.now)
Transaction.create(user_id: User.find_by(name: "Jeff Grove").id, stock_id: Stock.find_by(name: "Facebook").id, unit_cost: Stock.find_by(name: "Facebook").cost, quantity: 88, time: Time.now)
Transaction.create(user_id: User.find_by(name: "Jeff Grove").id, stock_id: Stock.find_by(name: "Starbucks").id, unit_cost: Stock.find_by(name: "Starbucks").cost, quantity: 50, time: Time.now)
Transaction.create(user_id: User.find_by(name: "Jeff Grove").id, stock_id: Stock.find_by(name: "Apple").id, unit_cost: Stock.find_by(name: "Apple").cost, quantity: 20, time: Time.now)

# DON'S TRANSACTIONS:

Transaction.create(user_id: User.find_by(name: "Don Drew").id, stock_id: Stock.find_by(name: "Amazon").id, unit_cost: Stock.find_by(name: "Amazon").cost, quantity: 15, time: Time.now)
Transaction.create(user_id: User.find_by(name: "Don Drew").id, stock_id: Stock.find_by(name: "Facebook").id, unit_cost: Stock.find_by(name: "Facebook").cost, quantity: 60, time: Time.now)
Transaction.create(user_id: User.find_by(name: "Don Drew").id, stock_id: Stock.find_by(name: "Starbucks").id, unit_cost: Stock.find_by(name: "Starbucks").cost, quantity: 20, time: Time.now)

# CASSIE'S TRANSACTIONS:

Transaction.create(user_id: User.find_by(name: "Cassie Rivers").id, stock_id: Stock.find_by(name: "Tesla").id, unit_cost: Stock.find_by(name: "Tesla").cost, quantity: 40, time: Time.now)
Transaction.create(user_id: User.find_by(name: "Cassie Rivers").id, stock_id: Stock.find_by(name: "Google").id, unit_cost: Stock.find_by(name: "Google").cost, quantity: 12, time: Time.now)

# ANDY'S TRANSACTIONS:

Transaction.create(user_id: User.find_by(name: "Andy Brind").id, stock_id: Stock.find_by(name: "Google").id, unit_cost: Stock.find_by(name: "Google").cost, quantity: 10, time: Time.now)
Transaction.create(user_id: User.find_by(name: "Andy Brind").id, stock_id: Stock.find_by(name: "Starbucks").id, unit_cost: Stock.find_by(name: "Starbucks").cost, quantity: 50, time: Time.now)

FavoritedStock.create(user_id: User.find_by(name: "Jeff Grove").id, stock_id: Stock.find_by(name: "Google").id)
FavoritedStock.create(user_id: User.find_by(name: "Don Drew").id, stock_id: Stock.find_by(name: "Google").id)
FavoritedStock.create(user_id: User.find_by(name: "Don Drew").id, stock_id: Stock.find_by(name: "Apple").id)
FavoritedStock.create(user_id: User.find_by(name: "Cassie Rivers").id, stock_id: Stock.find_by(name: "Starbucks").id)
FavoritedStock.create(user_id: User.find_by(name: "Cassie Rivers").id, stock_id: Stock.find_by(name: "Facebook").id)
FavoritedStock.create(user_id: User.find_by(name: "Cassie Rivers").id, stock_id: Stock.find_by(name: "Amazon").id)
FavoritedStock.create(user_id: User.find_by(name: "Andy Brind").id, stock_id: Stock.find_by(name: "Facebook").id)