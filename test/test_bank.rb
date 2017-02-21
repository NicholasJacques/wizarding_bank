require 'minitest/autorun'
require './lib/bank.rb'
require 'minitest/pride'

class BankTest < Minitest::Test

  def test_class_exist
    assert Bank.new("JP Morgan Chase")
  end

  def test_bank_has_a_name
    chase = Bank.new("JP Morgan Chase")
    assert_equal "JP Morgan Chase", chase.bank_name
  end

  def test_can_open_account_for_person
    chase = Bank.new("JP Morgan Chase")
    person_1 = Person.new("Minerva", 1000)
    chase.open_account(person_1)
    assert_equal ({"JP Morgan Chase"=>0}), person_1.bank_accounts
  end

  def test_bank_can_take_deposits
    chase = Bank.new("JP Morgan Chase")
    person_1 = Person.new("Minerva", 1000)
    chase.open_account(person_1)
    chase.deposit(person_1, 200)
    assert_equal ({"JP Morgan Chase"=>200}), person_1.bank_accounts
  end

  def test_cannot_deposit_more_than_cash
    chase = Bank.new("JP Morgan Chase")
    person_1 = Person.new("Minerva", 500)
    chase.open_account(person_1)
    chase.deposit(person_1, 700)
    assert_equal ({"JP Morgan Chase"=>0}), person_1.bank_accounts
  end

  def test_can_make_withdrawals
    chase = Bank.new("JP Morgan Chase")
    person_1 = Person.new("Minerva", 1000)
    chase.open_account(person_1)
    chase.deposit(person_1, 200)
    chase.withdrawal(person_1, 100)
    assert_equal ({"JP Morgan Chase"=>100}), person_1.bank_accounts
  end

  def test_cannot_overdraft
    chase = Bank.new("JP Morgan Chase")
    person_1 = Person.new("Minerva", 1000)
    chase.open_account(person_1)
    chase.deposit(person_1, 200)
    chase.withdrawal(person_1, 300)
    assert_equal ({"JP Morgan Chase"=>200}), person_1.bank_accounts
  end

  def test_transfer_to_another_bank
    chase = Bank.new("JP Morgan Chase")
    wells_fargo = Bank.new("Wells Fargo")
    person_1 = Person.new("Minerva", 1000)
    chase.open_account(person_1)
    wells_fargo.open_account(person_1)
    chase.deposit(person_1, 1000)
    chase.transfer(person_1, wells_fargo, 200)
    assert_equal ({"JP Morgan Chase"=>800, "Wells Fargo"=>200}), person_1.bank_accounts
  end

  def test_no_transfer_if_insufficient_funds
    chase = Bank.new("JP Morgan Chase")
    wells_fargo = Bank.new("Wells Fargo")
    person_1 = Person.new("Minerva", 1000)
    chase.open_account(person_1)
    wells_fargo.open_account(person_1)
    chase.deposit(person_1, 200)
    chase.transfer(person_1, wells_fargo, 1000)
    assert_equal ({"JP Morgan Chase"=>200, "Wells Fargo"=>0}), person_1.bank_accounts
  end

  def test_no_transfer_if_account_doesnt_exist
    chase = Bank.new("JP Morgan Chase")
    wells_fargo = Bank.new("Wells Fargo")
    person_1 = Person.new("Minerva", 1000)
    chase.open_account(person_1)
    chase.deposit(person_1, 200)
    chase.transfer(person_1, wells_fargo, 100)
    assert_equal ({"JP Morgan Chase"=>200}), person_1.bank_accounts
  end

  def test_total_cash_in_bank
    chase = Bank.new("JP Morgan Chase")
    person_1 = Person.new("Minerva", 1000)
    person_2 = Person.new("Harry", 3000)
    chase.open_account(person_1)
    chase.open_account(person_2)
    chase.deposit(person_1, 500)
    chase.deposit(person_2, 1000)
    chase.deposit(person_1, 100)
    assert_equal 1600, chase.total_cash
  end

end