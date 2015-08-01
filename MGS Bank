class TransactionAccount
  attr_accessor :balance
  attr_reader :name, :type

  def initialize(name, balance)
    @name = name
    @balance = balance.to_f
  end 

  def deposit(amount)
    self.balance += amount
  end 

  def withdraw(amount)
    self.balance -= amount
  end 

  def can_withdraw(amount)
    self.balance > amount
  end 
end 

class SavingAccount < TransactionAccount
end

class CheckingAccount < TransactionAccount
end

class BankAccount 
  attr_reader :name, :pin, :accounts

  def initialize(name, saving_account, checking_account)
    @name = name
    @pin = 1234
    @accounts = {
      "savings" => saving_account,
      "checking" => checking_account
    }
  end 
end 

class ATMSession
  attr_reader :account

  def initialize(account)
    @account = account
  end 

  def start()
    puts self.welcome_message
    self.check_pin
    self.menu
  end

  def welcome_message
    <<-EOS
    I hope you'll enjoy banking with me today. This is my first program ever -- and I'm so PUMPED!
    So you know, your PIN is 1234. (You won't be able to do ANY banking without it!)
    Welcome to MGS INVESTMENT BANK: today is #{Time.new.inspect}.
    EOS
  end

  def menu_message
    <<-EOS
    -- Type 'BALANCE' to view account balances.
    -- Type 'DEPOSIT' to deposit money into an account.
    -- Type 'WITHDRAW' to withdraw money from an account.
    -- Type 'TRANSFER' to transfer money between your accounts.
    -- Type 'EXIT' to exit your accounts.
    EOS
  end

  def menu()
    puts self.menu_message

    case self.user_input_text
    when "balance"
      self.balance_transaction
    when "deposit"
      self.deposit_transaction
    when "withdraw"
      self.withdrawal_transaction
    when "transfer"
      self.transfer_transaction
    when "exit"
      puts self.balance_summary
      puts self.exit_message
      exit
    else 
      puts "Sorry, I didn't understand you. Please re-enter your input."
    end 

    self.continue_menu

  end 

  def continue_menu
    puts "Would you like to complete another transaction? YES or NO?"
    
    case self.user_input_text
    when 'yes'
      self.check_pin
      self.menu
    when 'no'
      puts self.balance_summary
      puts self.exit_message
      exit
    else 
      puts self.error_message
      puts continue_menu
    end 
  end 

  def exit_message()
    <<-EOS
    On behalf of MGS Bank, thank you for your business.
    Have a nice day.
    EOS
  end

  def check_pin()
    puts "Please enter your PIN for security."
    self.verify_pin
    puts "Thank you."
  end 

  def verify_pin()
    if self.user_input_pin != self.account.pin
      puts "Incorrect PIN. Please re-enter your PIN."
      self.verify_pin
    end
  end 

  def balance_transaction()
    puts self.balance_summary
  end 

  def deposit_transaction
    puts "Which account would you like to deposity money into? SAVINGS for CHECKING?"
    account = self.get_account

    puts "How much would you like to deposit?"
    amount = user_input_amount

    account.deposit(amount)

    puts self.deposit_summary(account, amount)
  end 

  def withdrawal_transaction()
    puts "Which account would you like to withdraw money from? SAVINGS or CHECKING?"
    account = self.get_account

    puts "How much would you like to withdraw?"
    amount = user_input_amount

    if account.can_withdraw(amount)
      account.withdraw(amount)
      puts self.withdrawal_summary(account, amount)
    else 
      puts self.low_balance_error(account)
    end 
  end 

  def transfer_transaction()
    puts "Which account would you like to transfer money from? SAVINGS or CHECKING?"
    account_from = self.get_account

    if account_from == self.account.accounts['savings']
      account_to = self.account.accounts['checking']
    elsif account_from == self.account.accounts['checking']
      account_to = self.account.accounts['savings']
    end

    puts "How much would you like to transfer?"
    amount = user_input_amount

    if account_from.can_withdraw(amount)

      self.transfer(account_from, account_to, amount)
      
      puts self.transfer_summary(account_from, account_to, amount)
      puts self.balance_summary
    else 
      puts self.low_balance_error(account_from)
    end 
  end

   def get_account()
    account = user_input_text

    if self.account.accounts[account]
      self.account.accounts[account]
    else
      puts self.error_message
      self.get_account
    end 
  end 

  def error_message()
    "Sorry, I didn't understand you. Please re-enter your input."
  end 

  def transfer(account_from, account_to, amount)
    if account_from.can_withdraw(amount)
      account_from.withdraw(amount)
      account_to.deposit(amount)
    end 
  end

  def low_balance_error(account)
    "You do not have enough money to complete this transaction. Your balance is #{cash(account.balance)}."
  end 

  def deposit_summary(account, amount)
    "Deposited amount: #{cash(amount)}. New balance: #{cash(account.balance)}."
  end 

  def withdrawal_summary(account, amount)
    "Withdrawn amount: #{cash(amount)}. New balance: #{cash(account.balance)}."
  end 

  def transfer_summary(account_from, account_to, amount)
    "Transferred #{cash(amount)} from #{account_from.name} to #{account_to.name}."
  end 

  def balance_summary()
    savings = self.account.accounts["savings"]
    checking = self.account.accounts["checking"]

    "#{savings.name} balance: #{cash(savings.balance)}. #{checking.name} balance: #{cash(checking.balance)}."
  end 

  def user_input_text()
    gets.chomp.downcase
  end

  def user_input_amount()
    gets.chomp.to_s.tr('$,','').to_f
  end

  def user_input_pin()
    gets.chomp.to_i
  end

  def cash(amount)
    '$%.2f' % amount
  end
end

saving = SavingAccount.new("Your Savings", 1_000_000.00)
checking = CheckingAccount.new("Your Checking", 1_000_000.00)
user_account = BankAccount.new("Your Account", saving, checking)
atm = ATMSession.new(user_account)
atm.start


