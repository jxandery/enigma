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

  def invalid_message(message)
    check_for_invalid_chars(message).include?(false)
  end

  def message_decrypt_a(date, message, key)
    index_position =  rotator.a_rotation(key) + offset.a_offset(date) + character_to_index_key(message[0])
    character_map[index_position]
  end

  def message_decrypt_b(date, message, key)
    index_position =  rotator.b_rotation(key) + offset.b_offset(date) + character_to_index_key(message[1])
    character_map[index_position]
  end

  def message_decrypt_c(date, message, key)
    index_position =  rotator.c_rotation(key) + offset.c_offset(date) + character_to_index_key(message[2])
    character_map[index_position]
  end

  def message_decrypt_d(date, message, key)
    if character_to_index_key(message[3])
      index_position =  rotator.d_rotation(key) + offset.d_offset(date) + character_to_index_key(message[3])
      character_map[index_position]
    end
  end

  def batch_decrypt(date, message, key)
    batch = [message_decrypt_a(date, message, key),
    message_decrypt_b(date, message, key),
    message_decrypt_c(date, message, key),
    message_decrypt_d(date, message, key)]
  end

  def split_into_batches(message)
      message.downcase.scan /.{1,4}/
  end

  def decrypting(date, message, key)
    batches = split_into_batches(message)
    batches.map do |batch|
      @decrypted_message << batch_decrypt(date, batch, key)
    end
    decrypted_message.join
  end

  def decrypt(date, message, key)
    if invalid_message(message.downcase)
      "invalid character in message"
    else
      decrypting(date, message, key)
    end
  end
end
