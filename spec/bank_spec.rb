require 'bank'
describe Bank do
  it 'creates a bank account with 0 balance' do
    bank = Bank.new
    expect(bank.account.balance).to eq 0
  end
end
