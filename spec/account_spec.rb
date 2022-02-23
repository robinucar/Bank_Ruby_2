require 'account'
describe Account do
  let(:account) { Account.new }
  let(:account1) { Account.new(50) }
  it 'balance should  increase by deposit amount' do
    account.deposit(100, '21/02/2022')
    expect(account.balance).to eq 100
  end

	it 'should respond to deposit' do
		expect(account).to respond_to(:deposit).with(1..2).arguments
	end

	it 'should respond to withdraw' do
		expect(account).to respond_to(:withdraw).with(1..2).arguments
	end

  it 'balance should decrease by withdraw amount' do
    account.deposit(100, '21/Feb/2022')
    account.withdraw(25, '21/Feb/2022')
    expect(account.balance).to eq 75
  end

  it 'should not be able to withdraw money if balance is 0' do
    expect { account.withdraw(50, '21/02/2022') }.to raise_error('Payment Failed, your balance is 0')
  end

  it 'should not be able to withdraw money if balance is less than witdraw amount' do
    account.deposit(25, '21/02/2022')
    expect do
      account.withdraw(50, '21/02/2022').to raise_error('Payment Failed, your balance is less than witdraw amount')
    end
  end

  it 'should start with an empty transaction' do
    expect(account.transaction_list).to be_empty
  end

  it 'should store all transaction' do
    account.deposit(2500, '20/02/2022')
    account.withdraw(500, '21/02/2022')
    expect(account.transaction_list.length).to eq 2
  end

  it 'prints the table with the transactions' do
    table = <<~EOF
      +------------+--------+-------+---------+
      | date       | credit | debit | balance |
      +------------+--------+-------+---------+
      | 22/02/2022 |        | 500   | 4500    |
      | 21/02/2022 | 5000   |       | 5000    |
      +------------+--------+-------+---------+
    EOF

    account.deposit(5000, '21/02/2022')

    account.withdraw(500, '22/02/2022')

    expect { account.print_transaction }.to output(table).to_stdout
  end

  context 'edge cases' do
    it 'withdraw amount should be nil when deposit money' do
      account.deposit(500)
      expect(account.withdraw_amount).to be_nil
    end

    it 'deposit amount should be nil when withdraw money' do
      account1.withdraw(20)
      expect(account1.deposit_amount).to be_nil
    end
  end
end
