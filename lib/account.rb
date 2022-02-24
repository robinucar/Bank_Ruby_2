require 'date'
require 'terminal-table'
class Account
  attr_reader :balance, :transaction_list, :date

  STARTING_BALANCE = 0
  def initialize(balance = STARTING_BALANCE)
    @balance = balance
    @transaction_list = []
    @date = DateTime.now.strftime('%d/%m/%Y')
  end

  def deposit(amount)
    @balance += amount

    save_transaction(@date, amount, nil, @balance)
  end

  def withdraw(amount)
    raise 'Payment Failed, your balance is 0' if @balance.zero?
    raise 'Payment Failed, your balance is less than witdraw amount' if @balance < amount

    @balance -= amount
    save_transaction(@date, nil, amount, @balance)
  end

  def save_transaction(_date, deposit_amount, withdraw_amount, _balance)
    @transaction_list << { _date: @date, deposit: deposit_amount, withdraw: withdraw_amount, _balance: @balance }
  end

  def print_transaction
      puts 'date || credit || debit || balance'
    @transaction_list.each do |log|
      puts "#{log[:_date]} || #{log[:deposit]} || " + 
      "#{log[:withdraw]} || #{log[:_balance]}"
    end
  end
end
