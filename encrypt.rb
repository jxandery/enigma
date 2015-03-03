
 class Encrypt
  attr_reader :key

  def initialize(key)
    @key = key
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


 end
