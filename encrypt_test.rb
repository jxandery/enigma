gem 'minitest', '~> 5.2'
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require './encrypt'

class EncryptTest < Minitest::Test

  def test_it_exists
    assert Encrypt
  end

  def test_a_rotation_takes_first_two_digits_of_key
    encryptor = Encrypt.new(41521)
    assert_equal 41, encryptor.a_rotation
  end

  def test_b_rotation_takes_second_two_digits_of_key
    encryptor = Encrypt.new(41521)
    assert_equal 15, encryptor.b_rotation
  end

  def test_c_rotation_takes_third_two_digits_of_key
    encryptor = Encrypt.new(41521)
    assert_equal 52, encryptor.c_rotation
  end

  def test_d_rotation_takes_fourth_two_digits_of_key
    encryptor = Encrypt.new(41521)
    assert_equal 21, encryptor.d_rotation
  end

  def test_method_squares_date_with_first_char_as_zero
    encryptor = Encrypt.new(41521)
    assert_equal 412699225, encryptor.squares_date("020315")
  end

  def test_method_squares_date_with_first_char_not_zero
    encryptor = Encrypt.new(41521)
    assert_equal 14475699225, encryptor.squares_date("120315")
  end

  def test_a_offset_is_fourth_digit_from_end
    encryptor = Encrypt.new(41521)
    assert_equal 9, encryptor.a_offset("020315")
  end

  def test_b_offset_is_third_digit_from_end
    encryptor = Encrypt.new(41521)
    assert_equal 2, encryptor.b_offset("020315")
  end

  def test_c_offset_is_second_digit_from_end
    encryptor = Encrypt.new(41521)
    assert_equal 2, encryptor.c_offset("020315")
  end

  def test_d_offset_is_last_digit
    encryptor = Encrypt.new(41521)
    assert_equal 5, encryptor.d_offset("020315")
  end

end

