
 class Encrypt
  attr_reader :key, :character_map

  def initialize
    @key = key
    @character_map = character_map
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

  def index_position_map
    last_index_position = character_map.length - 1
    (0..last_index_position).to_a
  end

  def character_to_index_key(input)
    unique_char_map = character_map[0..38]
    indexes = (0..38).to_a
    char_index_key = unique_char_map.zip(indexes)
    char_index_key.map do |element|
      if element[0] == input
        input = element[1]
      end
      input
    end
  end

  def a_rotation
    key.to_s[0..1].to_i
  end

   def b_rotation
    key.to_s[1..2].to_i
  end

   def c_rotation
    key.to_s[2..3].to_i
  end

  def d_rotation
    key.to_s[3..4].to_i
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


# you've got character map with index positions
# "a" is index position 0
# find the index position for the letter
# the sum needs to be added to the index position
  def decode_four_chars

  end

  def splits_every_four_chars(message)
    message.chars.each_slice(4).to_a
  end

  def message_encrypt_a(date, message)
    sum =  a_rotation + a_offset(date)

  end

 end
