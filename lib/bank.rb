require './lib/person.rb'

class Bank

  attr_reader :bank_name

  def initialize(bank_name)
    puts "#{bank_name} has been created."
    @bank_name = bank_name
    @accounts = {}
    @account_holders = []
  end

  def open_account(person)
    puts "An account has been opened for #{person.person_name} with #{bank_name}."
    person.bank_accounts[bank_name] = 0
    @account_holders << person
  end

  def deposit(person, amount)
    if person.cash >= amount
      person.bank_accounts[bank_name] += amount.to_i
      puts "#{amount} galleons have been deposited into #{person.person_name}'s #{bank_name} account."
    else
      puts "{person.person_name} does not have enough cash to complete this deposit"
    end
  end

  def withdrawal(person, amount)
    if person.bank_accounts[bank_name] >= amount
      person.bank_accounts[bank_name] -= amount.to_i
      puts "#{amount} galleons have been withdrawn from #{person.person_name}'s #{bank_name} account. Balance: #{person.bank_accounts[bank_name]}."
    else
      puts "Insufficient Funds."
    end
  end

  def transfer(person, bank, amount)
    if (person.bank_accounts[bank_name] >= amount) && (person.bank_accounts.has_key?(bank.bank_name))
      person.bank_accounts[bank_name] -= amount
      person.bank_accounts[bank.bank_name] += amount.to_i
      puts "#{person.person_name} has transferred #{amount} galleons from #{bank_name} to #{bank.bank_name}."
    elsif (person.bank_accounts[bank_name] < amount) && (person.bank_accounts.has_key?(bank.bank_name))
      puts "Insufficient Funds"
    else
      puts "#{person.person_name} does not have an account with #{bank.bank_name}."
    end
  end

  def total_cash
    total = 0
    @account_holders.each do |person|
      total += person.bank_accounts[bank_name]
    end
    puts "Total Cash: #{total} galleons"
    total
  end
end