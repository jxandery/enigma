class Rotator
  attr_reader :key

  def initialize
    @key = key
  end

  def key
    new_key = (0..99999).to_a.sample
    new_key.to_s.rjust(5,"0")
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
  
end
