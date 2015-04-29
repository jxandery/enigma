require_relative 'rotator'
require_relative 'offset'
require 'pry'

class Encrypt
  attr_reader :character_map, :encrypted_message, :rotator, :offset, :key, :message_string, :encrypted_file

  def initialize(rotator = Rotator.new)
    @character_map = character_map
    @encrypted_message = []
    @rotator = rotator
    @offset = Offset.new
    @key = generate_key
    message_file = File.open("./#{ARGV[0]}", "r")
    @message_string = message_file.read
    @encrypted_file = File.open("./#{ARGV[1]}", "w")
  end

  def generate_key
    new_key = (0..99999).to_a.sample
    @key = new_key.to_s.rjust(5,"0")
  end

  def character_map
    char_map = ("a".."z").to_a + ("0".."9").to_a
    char_map << " "
    char_map << "."
    char_map << ","
    char_map * 4
  end

  def index_position_map
    last_index_position = character_map.length - 1
    (0..last_index_position).to_a
  end

  def character_to_index_key(input)
    unique_char_map = character_map[0..38]
    indexes = (0..38).to_a
    char_index_key = Hash[unique_char_map.zip(indexes)]
    char_index_key[input]
  end

  def check_for_invalid_chars(message)
    characters = message.downcase.chars
    characters.map do |char|
      if character_map.include?(char)
        true
      else
        false
      end
    end
  end

  def invalid_message(message)
    check_for_invalid_chars(message).include?(false)
  end

  def message_encrypt_a(date, message)
    index_position =  rotator.a_rotation(key) + offset.a_offset(date) + character_to_index_key(message[0])
    character_map[index_position]
  end

  def message_encrypt_b(date, message)
    if character_to_index_key(message[1])
      index_position =  rotator.b_rotation(key) + offset.b_offset(date) + character_to_index_key(message[1])
      character_map[index_position]
    end
  end

  def message_encrypt_c(date, message)
    if character_to_index_key(message[2])
      index_position =  rotator.c_rotation(key) + offset.c_offset(date) + character_to_index_key(message[2])
      character_map[index_position]
    end
  end

  def message_encrypt_d(date, message)
    if character_to_index_key(message[3])
      index_position =  rotator.d_rotation(key) + offset.d_offset(date) + character_to_index_key(message[3])
      character_map[index_position]
    end
  end

  def batch_encrypt(date, message)
    batch = [message_encrypt_a(date, message),
    message_encrypt_b(date, message),
    message_encrypt_c(date, message),
    message_encrypt_d(date, message)]
  end

  def split_into_batches(message)
    message.downcase.scan /.{1,4}/
  end

  def encrypting(date, message)
    batches = split_into_batches(message)
    batches.map do |batch|
      @encrypted_message << batch_encrypt(date, batch)
    end
    @encrypted_message = encrypted_message.join
  end

  def encrypt(date, message)
    message.delete!("\n")
    message.delete!('\\"')
    if invalid_message(message.downcase)
      encrypted_file.puts "invalid character in message"
      encrypted_file.close
    else
      encrypted_file.puts encrypting(date, message)
      encrypted_file.close
    end
  end

 end

encrypt_this_shit = Encrypt.new
encrypt_this_shit.encrypt("030915", encrypt_this_shit.message_string)

