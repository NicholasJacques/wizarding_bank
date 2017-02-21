require 'minitest/autorun'
require './lib/person.rb'
require 'minitest/pride'

class PersonTest < Minitest::Test

  def test_class_exists
    assert Person.new("Minerva", 1000)
  end 

  def test_class_takes_name_argument
    person_1 = Person.new("Minerva", 1000)
    assert_equal "Minerva", person_1.person_name
  end

  def test_class_takes_cash_argument
    person_1 = Person.new("Minerva", 1000)
    assert_equal 1000, person_1.cash
  end

end