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


end

