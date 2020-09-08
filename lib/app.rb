$prompt = TTY::Prompt.new

def greeting
    "Welcome to Quick Penny"
    user_info
end

def user_info
    name = $prompt.ask("What is your name?")
    email = $prompt.ask("What is your email?")
    password = $prompt.mask("What is your password?")
    display_user_info(name, email, password)
end

def display_user_info(name, email, password)
    p "Hello #{name}, your email is #{email}, and your password is #{password}"
end
