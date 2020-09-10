require 'pry'
$prompt = TTY::Prompt.new
require 'colorize'
require 'alphavantagerb'
$client = Alphavantage::Client.new key: "Y9WYOMPMM3PQFXOC"
    def greet
        puts "Welcome to Tricks of the Trade!".colorize(:light_blue)
        if $prompt.yes?("Do you have an existing account?")
            user_login
        else
            create_an_account
        end
    end

    def create_an_account
        user_full_name = $prompt.ask("To create an account, please enter your full name:")
        user_name = user_full_name.split[0]
        user_email = $prompt.ask("Please enter your email address:")
        user_password = $prompt.ask("Please create a password for your account (You will be required to enter this when logging in):")
        user_balance = $prompt.ask("Please enter your initial deposit amount. A deposit of at least $10 is required for account creation:")
        while user_balance.to_f < 10.00 do
            user_balance = $prompt.ask("Please enter an amount of $10.00 or more.")
        end
            
        $user_object = User.create(name: user_full_name, email: user_email, password: user_password, balance: user_balance)
        greet_with_name(user_name)
    end

    def user_login
        user_full_name = $prompt.ask("Please enter your full name:")
        $user_object = User.find_by(name: user_full_name)
        if $user_object == nil
            login_name_rejected
        end
        user_name = user_full_name.split[0]
        passwordd = $prompt.mask("Please enter password:")
        if passwordd.downcase != $user_object.password.downcase
            login_password_rejected
        else
            greet_with_name(user_name)
        end
    end

    def login_password_rejected
        response = $prompt.mask("Password invalid, please enter the correct password associated with this account. If you have forgotten your password, please enter your email address or type 'create new account'.")
        if response.downcase == $user_object.password.downcase
            greet_with_name($user_object.name)
        elsif response.downcase == "create an account" || response.downcase == "create account" || response.downcase == "create new account" || response.downcase == "new account"
            create_an_account
        elsif response.downcase == $user_object.email.downcase
            greet_with_name($user_object.name)
        else
            puts "I'm sorry, that response was not recognized. Returning you to login screen.".colorize(:red)
            user_login
        end
    end

    def login_name_rejected
        response = $prompt.select("That name does not match an account in our system.", ["Try again"], ["Create an account"])
        if response == "Try again"
            user_login
        else
            create_an_account
        end
    end

    def greet_with_name(name)
        selection = $prompt.select("Hello #{name}, please select from the following options:", ["View a stock", "View your watchlist", "View your account information"])
        if selection == "View a stock"
            stock = $prompt.ask("What stock would you like to view?")
            get_stock_info(stock)
        elsif selection == "View your watchlist"
            my_watchlists
        else
            my_account
        end
    end

    def get_stock_info(stock_input)
        stocks_found = $client.search keywords: stock_input
        if stocks_found.stocks[0] == nil
            stock_input2 = $prompt.ask("We're sorry, we could not locate the stock you entered, please re-enter a stock name or symbol:")
            get_stock_info(stock_input2)
        else
            stock_symbol = stocks_found.stocks[0].symbol
            stock = $client.stock symbol: stock_symbol
            stock_quote = stock.quote
            stock_object = Stock.create(name: stocks_found.stocks[0].name, symbol: stock_quote.symbol, cost: stock_quote.price, change: stock_quote.change)
            puts "The cost of #{stocks_found.stocks[0].name} stock is $#{stock_quote.price} per share. The percent change since yesterday is #{stock_quote.change_percent}.".colorize(:light_blue)
            purchase = $prompt.yes?("Would you like to purchase this stock?")
            if purchase
                purchase_stock(stock_object)
            elsif $prompt.yes?("Would you like to add this stock to your watchlist?")
                add_to_watchlist(stock_object)
            else
                what_next
            end
        end
    end

    def purchase_stock(stock)
        quantity = $prompt.ask("Please enter the quantity you would like to purchase.")
        total = (quantity.to_i * stock.cost).round(2)
        if $prompt.yes?("Your total for #{quantity} shares of #{stock.name} comes to $#{total}. Please confirm you would like to proceed.")
            Transaction.create(user_id: $user_object.id, stock_id: stock.id, total: total, time: Time.now)
            puts "Transaction successful! Congratulations, you just purchased #{quantity} shares of #{stock.name}.".colorize(:green)
        else
            puts "Transaction has been canceled.".colorize(:red)
        end
        
        if $prompt.yes?("Would you like to view another stock?")
            stock = $prompt.ask("What stock are you interested in viewing?")
            get_stock_info(stock)
        else
            what_next
        end

    end

    def add_to_watchlist(stock_input)
        stocks_found = $client.search keywords: stock_input
        stock_symbol = stocks_found.stocks[0].symbol
        stock = $client.stock symbol: stock_symbol
        stock_quote = stock.quote
        stock_object = Stock.create(name: stocks_found.stocks[0].name, symbol: stock_quote.symbol, cost: stock_quote.price, change: stock_quote.change)
        Watchlist.create(user_id: $user_object.id, stock_id: stock_object.id)
        puts "This stock has been added to your watchlist!".colorize(:green)
        what_next
    end

    def my_transactions
        result = $user_object.transactions.map {|t| t.total}
        total_cost = result.map {|t| t.round(2)}
        total_costs = total_cost.join(', $')
        puts "Your previous transaction totals are: $#{total_costs}. You have spent a total of $#{total_cost.sum}.".colorize(:light_blue)
        what_next
    end

    def my_watchlists
        result = $user_object.watchlists.map {|t| t.stock.name}
        if result == []
            if $prompt.yes?("You are not currently watching any stocks. Would you like to add a stock to your watchlist?")
                stock = $prompt.ask("What stock would you like to add to your watchlist?").capitalize
                add_to_watchlist(stock)
            else
                what_next
            end
        else 
            results = result.join(', ')
            puts "You are currently watching the following stocks: #{results}.".colorize(:light_blue)
            what_next
        end
    end

    def what_next
        selection = $prompt.select("Where to next? Please select from the following options:", ["Return to the main menu", "Log off"])
        if selection == "Return to the main menu"
            greet_with_name($user_object.name)
        else
            puts "Thank you for using Tricks of the Trade! See you again soon.".colorize(:light_blue)
        end
    end

    def my_account
        selection = $prompt.select("Account options for #{$user_object.name}:", ["View previous transactions", "View connected email address", "Return to main menu", "Log Off", "Delete Account"])
        if selection == "View previous transactions"
            my_transactions
        elsif selection == "View connected email address"
            puts "The email address connected to this account is: #{$user_object.email}".colorize(:light_blue)
            what_next
        elsif selection == "Log Off"
            puts "Thank you for using Tricks of the Trade! See you again soon.".colorize(:light_blue)
        elsif selection == "Return to main menu"
            greet_with_name($user_object.name)
        else
            User.find_by(id: $user_object.id).destroy
            puts "Account successfully deleted. Thank you for using Tricks of the Trade, we hope you come back soon.".colorize(:light_blue)
        end  
    end



