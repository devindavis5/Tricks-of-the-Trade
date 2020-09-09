require 'pry'
$prompt = TTY::Prompt.new

    def greet
        p "Welcome to Tricks of the Trade!"
        if $prompt.yes?("Do you have an existing account?")
            user_login
        else
            create_an_account
        end
    end

    def create_an_account
        user_full_name = $prompt.ask("Please enter your full name:")
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
        # $user_object = User.find_by(name: user_full_name)
        user_name = user_full_name.split[0]
        password = $prompt.mask("Please enter password:")
        # if password != $user_object.password
        #     $prompt.mask("Password invalid, please enter the correct password associated with this account.")
        # else
            greet_with_name(user_name)
    end

    def greet_with_name(name)
        stock = $prompt.ask("Hello #{name}, What stock are you interested in viewing?")
        get_stock_info(stock)
    end

    def get_stock_info(name)
        stock = Stock.find_by(name: "#{name}")
        p "#{name} is in the #{stock.industry} industry with a cost of $#{stock.cost} per share."
        purchase = $prompt.yes?("Would you like to purchase this stock?")
        if purchase
            purchase_stock(stock)
        else
            add_to_watchlist(stock)
        end
    end

    def purchase_stock(stock)
        quantity = $prompt.ask("Please enter the quantity you would like to purchase.")
        binding.pry
        total = quantity.to_i * stock.cost
        if $prompt.yes?("Your total for #{quantity} shares of #{stock.name} comes to $#{total}. Please confirm you would like to proceed.")
            binding.pry
            # Transaction.new(user_id: $user_object.id, stock_id: stock.id, unit_cost: stock.cost, quantity: quantity, time: Time.now)
            p "Transaction successful! Congratulations, you just purchased #{quantity} shares of #{stock.name}."
        else
            p "Transaction has been canceled."
        end
        
        if $prompt.yes?("Would you like to view another stock?")
            stock = $prompt.ask("What stock are you interested in viewing?")
            get_stock_info(stock)
        else
            p "Thank you for using Tricks of the Trade! See you again soon."
        end

    end

    def add_to_watchlist(stock)
        watchlist = $prompt.yes?("Would you like to add this stock to your watchlist?")
        if watchlist
            # Watchlist.new(user_id: $user_object.id, stock_id: stock.id)
            p "This stock has been added to your watchlist!"
        elsif $prompt.yes?("Would you like to view another stock?")
            stock_name = $prompt.ask("What stock are you interested in viewing?")
            get_stock_info(stock_name)
        else
            p "Thank you for using Tricks of the Trade! See you again soon."
        end
    end

