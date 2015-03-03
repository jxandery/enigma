
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



 end
