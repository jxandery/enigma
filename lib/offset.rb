class Offset

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
