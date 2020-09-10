User.destroy_all
Stock.destroy_all
Transaction.destroy_all
Watchlist.destroy_all

jeff = User.create(name: "Jeff Grove", email: "jgrove@gmail.com", password: "Locksmith32", balance: 305000.00)
don = User.create(name: "Don Drew", email: "ddrew4234@gmail.com", password: "justapiece10349", balance: 210000.00)
cassie = User.create(name: "Cassie Rivers", email: "casscass65@yahoo.com", password: "valleymountain88", balance: 150000.00)
andy = User.create(name: "Andy Brind", email: "andytbrind@gmail.com", password: "rosie2002", balance: 200000.00)
devin = User.create(name: "Devin Davis", email: "devinrdavis555@gmail.com", password: "5", balance: 200000.00)

s1 = Stock.create(name: "Facebook", industry: "information technology", cost: 271.16)
s2 = Stock.create(name: "Amazon", industry: "e-commerce", cost: 3149.84)
s3 = Stock.create(name: "Tesla", industry: "automotive", cost: 330.21)
s4 = Stock.create(name: "Google", industry: "internet cloud computing", cost: 1523.60)
s5 = Stock.create(name: "Starbucks", industry: "retail coffee", cost: 85.41)
s6 = Stock.create(name: "Apple", industry: "computer hardware & software", cost: 112.82)

# JEFF'S TRANSACTIONS:

t1 = Transaction.create(user_id: jeff.id, stock_id: s3.id, unit_cost: s3.cost, quantity: 50, time: Time.now)
t2 = Transaction.create(user_id: jeff.id, stock_id: s1.id, unit_cost: s1.cost, quantity: 88, time: Time.now)
t3 = Transaction.create(user_id: jeff.id, stock_id: s5.id, unit_cost: s5.cost, quantity: 50, time: Time.now)
t4 = Transaction.create(user_id: jeff.id, stock_id: s6.id, unit_cost: s6.cost, quantity: 20, time: Time.now)

# DON'S TRANSACTIONS:

t5 = Transaction.create(user_id: don.id, stock_id: s2.id, unit_cost: s2.cost, quantity: 15, time: Time.now)
t6 = Transaction.create(user_id: don.id, stock_id: s1.id, unit_cost: s1.cost, quantity: 60, time: Time.now)
t7 = Transaction.create(user_id: don.id, stock_id: s5.id, unit_cost: s5.cost, quantity: 20, time: Time.now)

# CASSIE'S TRANSACTIONS:

t8 = Transaction.create(user_id: cassie.id, stock_id: s3.id, unit_cost: s3.cost, quantity: 40, time: Time.now)
t9 = Transaction.create(user_id: cassie.id, stock_id: s4.id, unit_cost: s4.cost, quantity: 12, time: Time.now)

# ANDY'S TRANSACTIONS:

t10 = Transaction.create(user_id: andy.id, stock_id: s4.id, unit_cost: s4.cost, quantity: 10, time: Time.now)
t11 = Transaction.create(user_id: andy.id, stock_id: s5.id, unit_cost: s5.cost, quantity: 50, time: Time.now)

w1 = Watchlist.create(user_id: jeff.id, stock_id: s4.id)
w2 = Watchlist.create(user_id: don.id, stock_id: s4.id)
w3 = Watchlist.create(user_id: don.id, stock_id: s6.id)
w4 = Watchlist.create(user_id: cassie.id, stock_id: s5.id)
w5 = Watchlist.create(user_id: cassie.id, stock_id: s1.id)
w6 = Watchlist.create(user_id: cassie.id, stock_id: s2.id)
w7 = Watchlist.create(user_id: andy.id, stock_id: s1.id)