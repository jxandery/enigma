
 class Encrypt
  attr_reader :key, :character_map, :encrypted_message

  def initialize
    @key = key
    @character_map = character_map
    @encrypted_message = []
  end

  def key
    new_key = (0..99999).to_a.sample
    new_key.to_s.rjust(5,"0")
  end

  def character_map
    char_map = ("a".."z").to_a + (0..9).to_a
    char_map << " "
    char_map << "."
    char_map << ","
    char_map * 4
  end

  def a_rotation
    key[0..1].to_i
  end

   def b_rotation
    key[1..2].to_i
  end

   def c_rotation
    key[2..3].to_i
  end

  def d_rotation
    key[3..4].to_i
  end

  def squares_date(date)
      (date.to_i) **2
  end

  def a_offset(date)
    offsets = squares_date(date).to_s.chars
    offsets[-4].to_i
  end

  def b_offset(date)
    offsets = squares_date(date).to_s.chars
    offsets[-3].to_i
  end

  def c_offset(date)
    offsets = squares_date(date).to_s.chars
    offsets[-2].to_i
  end

  def d_offset(date)
    offsets = squares_date(date).to_s.chars
    offsets[-1].to_i
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
    if check_for_invalid_chars(message).include?(false)
      "invalid character in message"
    end
  end

  # def message_encrypt_a(date, message)
  #   input = splits_every_four_chars(message)[0]
  #   index_position =  a_rotation + a_offset(date) + character_to_index_key(input[0])
  #   character_map[index_position]
  # end

  def message_encrypt_a(date, message)
    index_position =  a_rotation + a_offset(date) + character_to_index_key(message[0])
    character_map[index_position]
  end

  def message_encrypt_b(date, message)
    index_position =  b_rotation + b_offset(date) + character_to_index_key(message[1])
    character_map[index_position]
  end

  def message_encrypt_c(date, message)
    index_position =  c_rotation + c_offset(date) + character_to_index_key(message[2])
    character_map[index_position]
  end

  def message_encrypt_d(date, message)
    index_position =  d_rotation + d_offset(date) + character_to_index_key(message[3])
    character_map[index_position]
  end

  def batch_encrypt(date, message)
    batch = [message_encrypt_a(date, message),
    message_encrypt_b(date, message),
    message_encrypt_c(date, message),
    message_encrypt_d(date, message)]
  end

  def split_into_batches(message) #"what the what."
    message.scan /.{1,4}/         #["what", " the", " wha", "t."]
  end

  def encrypting(date, message)
    batches = split_into_batches(message) # ["what"," the"," wha","t.""]
    batches.map do |batch|                # ["what"]
      @encrypted_message << batch_encrypt(date, batch)  # ["y",5,8,"x"]

    end
    @encrypted_message = encrypted_message.join

    end
 end
