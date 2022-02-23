require 'date'
require 'terminal-table'
class Account
  attr_reader :balance, :transaction_list
  attr_accessor :deposit_amount, :withdraw_amount

  STARTING_BALANCE = 0
  def initialize(balance = STARTING_BALANCE)
    @balance = balance
    @transaction_list = []
  end

  def deposit(deposit_amount, date = DateTime.now.strftime('%d/%m/%Y'))
    @deposit_amount = deposit_amount
    @date = date
    @balance += @deposit_amount
    @withdraw_amount = nil
    save_transaction
  end

  def withdraw(withdraw_amount, date = DateTime.now())
    @withdraw_amount = withdraw_amount
    @deposit_amount = nil
    @date = date
    raise 'Payment Failed, your balance is 0' if @balance == 0
    raise 'Payment Failed, your balance is less than witdraw amount' if @balance < @withdraw_amount

    @balance -= @withdraw_amount
    save_transaction
  end

  def save_transaction
    @transaction_list << { date: @date, deposit: @deposit_amount, withdraw: @withdraw_amount, balance: @balance }
  end

  def print_transaction
    rows = []
    table = Terminal::Table.new rows: rows
    i = @transaction_list.length
    while i > 0
      rows << [@transaction_list[i - 1][:date], @transaction_list[i - 1][:deposit], @transaction_list[i - 1][:withdraw], @transaction_list[i - 1][:balance]]
      i -= 1
    end
    table = Terminal::Table.new rows: rows
    table = Terminal::Table.new headings: %w[date credit debit balance], rows: rows
    puts table
  end
end
