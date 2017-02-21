class Person
  attr_reader :person_name,
              :cash

attr_accessor :bank_accounts

  def initialize(person_name, cash)
    puts "#{person_name} has been created with #{cash} galleons cash."
    @person_name = person_name
    @cash = cash
    @bank_accounts = {}
  end
end