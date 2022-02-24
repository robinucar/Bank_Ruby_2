require 'account'
require 'date'
describe Account do
  let(:account) { Account.new }
  let(:account1) { Account.new(50) }
  it 'balance should  increase by deposit amount' do
    account.deposit(100)
    expect(account.balance).to eq 100
  end

  it 'balance should decrease by withdraw amount' do
    account.deposit(100)
    account.withdraw(25)
    expect(account.balance).to eq 75
  end

  it 'should not be able to withdraw money if balance is 0' do
    expect { account.withdraw(50) }.to raise_error('Payment Failed, your balance is 0')
  end

  it 'should not be able to withdraw money if balance is less than witdraw amount' do
    account.deposit(25)
    expect do
      account.withdraw(50).to raise_error('Payment Failed, your balance is less than witdraw amount')
    end
  end

  it 'should start with an empty transaction' do
    expect(account.transaction_list).to be_empty
  end

  it 'should store all transaction' do
    account.deposit(2500)
    account.withdraw(500)
    expect(account.transaction_list.length).to eq 2
  end

  it 'prints the table with the transactions' do
    account.deposit(100)
    account.withdraw(50)
    expect { account.print_transaction() }.to output("date || credit || debit || balance\n" +
      "#{Time.now.strftime('%d/%m/%Y')} || 100 ||  || 100\n" + 
      "#{Time.now.strftime('%d/%m/%Y')} ||  || 50 || 50\n").to_stdout
  end
end
