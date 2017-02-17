class Person
  attr_reader :name,
              :cash

  def initialize(name, cash)
    @name = name
    @cash = cash
    #puts "#{name} has been created with #{cash} galleons cash."
  end

end

Person.new("Minerva", 1000)