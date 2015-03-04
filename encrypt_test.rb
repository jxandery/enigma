gem 'minitest', '~> 5.2'
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require './encrypt'

class EncryptTest < Minitest::Test
  attr_reader :encryptor

  def setup
    @encryptor = Encrypt.new
  end

  def test_it_exists
    assert Encrypt
  end

  def test_a_rotation_takes_first_two_digits_of_key
    encryptor.stub :key, (41521) do
      assert_equal 41, encryptor.a_rotation
    end
  end

  def test_b_rotation_takes_second_two_digits_of_key
    encryptor.stub :key, (41521) do
      assert_equal 15, encryptor.b_rotation
    end
  end

  def test_c_rotation_takes_third_two_digits_of_key
    encryptor.stub :key, (41521) do
      assert_equal 52, encryptor.c_rotation
    end
  end

  def test_d_rotation_takes_fourth_two_digits_of_key
    encryptor.stub :key, (41521) do
      assert_equal 21, encryptor.d_rotation
    end
  end

  def test_method_squares_date_with_first_char_as_zero
    assert_equal 412699225, encryptor.squares_date("020315")
  end

  def test_method_squares_date_with_first_char_not_zero
    assert_equal 14475699225, encryptor.squares_date("120315")
  end

  def test_a_offset_is_fourth_digit_from_end
    assert_equal 9, encryptor.a_offset("020315")
  end

  def test_b_offset_is_third_digit_from_end
    assert_equal 2, encryptor.b_offset("020315")
  end

  def test_c_offset_is_second_digit_from_end
    assert_equal 2, encryptor.c_offset("020315")
  end

  def test_d_offset_is_last_digit
    assert_equal 5, encryptor.d_offset("020315")
  end

  def test_a_offset_and_a_rotation_returns_number_of_positions_moved
    skip
    encryptor.stub :key, (41521) do
     assert_equal 50, encryptor.message_encrypt_a("020315")
    end
  end

  def test_index_position_map_returns_character_map_length
    assert_equal 155, encryptor.index_position_map.last
  end

  def test_message_splits_into_four_char_arrays
    assert_equal ["t", "."], encryptor.splits_every_four_chars("what the what.")[-1]
  end

  def test_character_to_index_position_key_returns_correct_value
    encryptor.stub :key, (41521) do
     assert_equal 3, encryptor.character_to_index_key("c")
    end
  end


end
