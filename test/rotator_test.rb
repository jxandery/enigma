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

  def test_formatted_key_is_a_string
    @rotator = Rotator.new
    assert_equal String, rotator.key.class
  end

  def test_formatted_key_is_five_characters_long
    @rotator = Rotator.new
    assert_equal 5, rotator.key.length
  end

  def test_a_rotation_takes_first_two_digits_of_key
    rotator.stub :key, ("41521") do
      assert_equal 41, rotator.a_rotation
    end
  end

  def test_b_rotation_takes_second_two_digits_of_key
    rotator.stub :key, ("41521") do
      assert_equal 15, rotator.b_rotation
    end
  end

  def test_c_rotation_takes_third_two_digits_of_key
    rotator.stub :key, ("41521") do
      assert_equal 52, rotator.c_rotation
    end
  end

  def test_d_rotation_takes_fourth_two_digits_of_key
    rotator.stub :key, ("41521") do
      assert_equal 21, rotator.d_rotation
    end
  end

end
