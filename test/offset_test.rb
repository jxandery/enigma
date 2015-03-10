require 'simplecov'
SimpleCov.start

gem 'minitest', '~> 5.2'
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require_relative '../lib/offset'

class OffsetTest < Minitest::Test
  attr_reader :offset

  def setup
    @offset = Offset.new
  end

  def test_it_exists
    assert Offset
  end

  def test_date_input_is_a_string
    skip
    offset = Offset.new
    assert_equal string, offset.date_key.class
  end

  def test_date_input_length_is_six_characters
    skip
    offset = Offset.new
    assert_equal String, offset.date_key.class
  end

  def test_date_input_is_a_fixnum_when_converted_to_integer
    skip
    offset = Offset.new
    assert_equal String, offset.date_key.class
  end

  def test_method_squares_date_with_first_char_as_zero
    assert_equal 412699225, offset.squares_date("020315")
  end

  def test_method_squares_date_with_first_char_not_zero
    assert_equal 14475699225, offset.squares_date("120315")
  end

  def test_a_offset_is_fourth_digit_from_end
    assert_equal 9, offset.a_offset("020315")
  end

  def test_b_offset_is_third_digit_from_end
    assert_equal 2, offset.b_offset("020315")
  end

  def test_c_offset_is_second_digit_from_end
    assert_equal 2, offset.c_offset("020315")
  end

  def test_d_offset_is_last_digit
    assert_equal 5, offset.d_offset("020315")
  end

end
