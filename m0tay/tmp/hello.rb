# hello.rb

class Greeter
  def initialize(age, name)
    @name = name
  end

  def say_hello
    puts "Hello, #{@name}!"
  end

  def say_goodbye
    puts "Goodbye, #{@name}!"
  end
end

# Create an object
person = Greeter.new("Douglas")

# Call the methods
person.say_hello
person.say_goodbye
