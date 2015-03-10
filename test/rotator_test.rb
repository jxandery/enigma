require 'simplecov'
SimpleCov.start

gem 'minitest', '~> 5.2'
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require_relative '../lib/rotator'

class RotatorTest < Minitest::Test
  attr_reader :rotator

  def setup
    @rotator = Rotator.new
  end

  def test_it_exists
    assert Rotator
  end

  def test_each_rotation_is_a_fixnum
    assert_equal Fixnum, rotator.a_rotation("41521").class
    assert_equal Fixnum, rotator.b_rotation("41521").class
    assert_equal Fixnum, rotator.c_rotation("41521").class
    assert_equal Fixnum, rotator.d_rotation("41521").class
  end

  def test_each_rotation_is_two_characters_long
    assert_equal 2, rotator.a_rotation("41521").to_s.length
    assert_equal 2, rotator.b_rotation("41521").to_s.length
    assert_equal 2, rotator.c_rotation("41521").to_s.length
    assert_equal 2, rotator.d_rotation("41521").to_s.length
  end

  def test_a_rotation_takes_first_two_digits_of_key
      assert_equal 41, rotator.a_rotation("41521")
  end

  def test_b_rotation_takes_second_two_digits_of_key
      assert_equal 15, rotator.b_rotation("41521")
  end

  def test_c_rotation_takes_third_two_digits_of_key
      assert_equal 52, rotator.c_rotation("41521")
  end

  def test_d_rotation_takes_fourth_two_digits_of_key
      assert_equal 21, rotator.d_rotation("41521")
  end

end
