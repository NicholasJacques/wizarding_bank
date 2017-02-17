require 'minitest/autorun'
require './lib/bank.rb'
require 'minitest/pride'

class BankTest < Minitest::Test

  def test_class_exist
    assert Bank.new
  end

end