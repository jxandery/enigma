require_relative 'rotator'
require_relative 'offset'
require_relative 'encrypt'

class Decrypt
  attr_reader :character_map, :decrypted_message, :rotator, :offset

  def initialize(rotator = Rotator.new)
    @character_map = character_map
    @decrypted_message = []
    @rotator = rotator
    @offset = Offset.new
  end

  def character_map
    char_map = ("a".."z").to_a + ("0".."9").to_a
    char_map << " "
    char_map << "."
    char_map << ","
    char_map.reverse * 4
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
    characters = message.chars
    characters.map do |char|
      if character_map.include?(char)
        true
      else
        false
      end
    end
  end

  def invalidate_message(message)
    check_for_invalid_chars(message).include?(false)
  end

  def message_decrypt_a(date, message)
    index_position =  rotator.a_rotation + offset.a_offset(date) + character_to_index_key(message[0])
    character_map[index_position]
  end

  def message_decrypt_b(date, message)
    index_position =  rotator.b_rotation + offset.b_offset(date) + character_to_index_key(message[1])
    character_map[index_position]
  end

  def message_decrypt_c(date, message)
    index_position =  rotator.c_rotation + offset.c_offset(date) + character_to_index_key(message[2])
    character_map[index_position]
  end

  def message_decrypt_d(date, message)
    index_position =  rotator.d_rotation + offset.d_offset(date) + character_to_index_key(message[3])
    character_map[index_position]
  end

  def batch_decrypt(date, message)
    batch = [message_decrypt_a(date, message),
    message_decrypt_b(date, message),
    message_decrypt_c(date, message),
    message_decrypt_d(date, message)]
  end

  def split_into_batches(message)
    if invalidate_message(message.downcase)
      "invalid character in message"
    else
      message.downcase.scan /.{1,4}/
    end
  end

  def decrypting(date, message)
    batches = split_into_batches(message)
    batches.map do |batch|
      @decrypted_message << batch_decrypt(date, batch)
    end
    puts rotator.key
    @decrypted_message = decrypted_message.join
  end

 end
