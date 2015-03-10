require_relative './decrypt'

class Crack
  attr_reader :cracker, :counter

  def initialize
    @counter = "00000"
    @cracker = Decrypt.new
    @cracked_message = []
  end

  def last_seven(message)
    message[-7..-1]
  end

  def starting_point(message)
  end

  def crack(date, message, key)
    @cracked_message << cracker.decrypt(date, message, key)
    puts @cracked_message
    cracker.decrypt(date, message, key)[0..4]
  end

end
