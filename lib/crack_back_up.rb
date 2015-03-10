require_relative './decrypt'
require 'pry'

class CrackBackUp
  attr_reader :counter, :decryptor

  def initialize
    @counter = 0
    @decryptor = Decrypt.new
  end

  def crack(date, message)
    @counter = counter.to_s.rjust(5,"0")
    until decryptor.decrypt(date, message, counter)[-7..-1] == "..end.."
      @counter = counter.to_s.rjust(5,"0")
      decryptor.decrypt(date, message, counter)
      @counter = counter.to_i
      @counter += 1
      @counter = counter.to_s.rjust(5,"0")
    end
    puts "#{counter}"
  end


end
