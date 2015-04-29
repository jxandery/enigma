require_relative './decrypt'
require 'pry'

class Crack
  attr_reader :cracker, :counter, :offset #:decoder

  def initialize
    @counter = "00000"
    @cracker = Decrypt.new
    @cracked_message = []
    @indexes = []
    @offset = Offset.new
    # @decoder = "..end.."
  end

  def last_seven(message)
    message[-7..-1]
  end

  # def starting_point(message)
  # end
  #
  # def crack(date, message, key)
  #   @cracked_message << cracker.decrypt(date, message, key)
  #   puts @cracked_message
  #   cracker.decrypt(date, message, key)[0..4]
  # end

  def index_positions(message)
      indexes = []
      cracker.character_map.each_with_index do |char, index|
        if char == message
          indexes << index
        end
      end
      indexes
  end

  def reverse_shift(date, message)
    index_positions(message[0])[0]  + offset.a_offset(date)
  end

  def possible_rotations(date, message, decoder)
    potential_rotations = index_positions(decoder).map do |position|
      position - reverse_shift(date, message)
    end
  end

end
