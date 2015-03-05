require 'simplecov'
SimpleCov.start

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
    encryptor.stub :key, ("41521") do
      assert_equal 41, encryptor.a_rotation
    end
  end

  def test_b_rotation_takes_second_two_digits_of_key
    encryptor.stub :key, ("41521") do
      assert_equal 15, encryptor.b_rotation
    end
  end

  def test_c_rotation_takes_third_two_digits_of_key
    encryptor.stub :key, ("41521") do
      assert_equal 52, encryptor.c_rotation
    end
  end

  def test_d_rotation_takes_fourth_two_digits_of_key
    encryptor.stub :key, ("41521") do
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

  def test_index_position_map_returns_character_map_length
    assert_equal 155, encryptor.index_position_map.last
  end

  def test_message_only_contains_valid_characters
     assert_equal "invalid character in message", encryptor.splits_every_four_chars("$not needed now")
  end

  def test_message_splits_into_four_char_arrays
    assert_equal ["t", "."], encryptor.splits_every_four_chars("what the what.")[-1]
  end

  def test_character_to_index_position_key_returns_correct_value
    encryptor.stub :key, ("41521") do
     assert_equal 2, encryptor.character_to_index_key("c")
    end
  end

  def test_a_offset_and_a_rotation_returns_number_of_positions_moved
    skip
    encryptor.stub :key, ("41521") do
      assert_equal 50, encryptor.message_encrypt_a("020315", "not needed now")
    end
  end

  def test_char_index_key_and_a_rotation_and_offset_returns_correct_character_map_index_position
    skip
    encryptor.stub :key, ("41521") do
      assert_equal 63, encryptor.message_encrypt_a("020315", "not needed now")
    end
  end

  # reads message
  # splits into array of four characters arrays
  # takes the first element of first array
  # finds the corresponding char_index_key value
  # calculates the corresponding rotation & offset value
  # starting at the char_index_key value, the element moves forward by the rotation & offset value
  # returns that element/correct character
  def test_combine_number_of_positions_moved_and_message_returns_correct_value_aka_message_encrypt_a_works
    encryptor.stub :key, ("41521") do
      assert_equal "y", encryptor.message_encrypt_a("020315", "not needed now")
    end
  end

  def test_message_encrypt_a_works_for_a_different_key
   encryptor.stub :key, ("87521") do
     assert_equal 5, encryptor.message_encrypt_a("020315", "not needed now")
   end
  end

  def test_message_encrypt_a_works_for_highest_possible_rotation_key_of_value_99
    encryptor.stub :key, ("99521") do
      assert_equal "e", encryptor.message_encrypt_a("020315", "not needed now")
    end
  end

  def test_message_encrypt_a_works_for_lowest_possible_rotation_key_of_value_00
    encryptor.stub :key, ("00521") do
      assert_equal "w", encryptor.message_encrypt_a("020315", "not needed now")
    end
  end

  def test_message_encrypt_a_works_where_a_rotation_key_value_is_less_than_10
    skip
    encryptor.stub :key, ("03521") do
      assert_equal "what is this craziness", encryptor.message_encrypt_a("020315", "not needed now")
    end
  end

  def test_message_encrypt_a_works_where_a_rotation_key_value_is_negative
    encryptor.stub :key, ("-41521") do
      assert_equal "y", encryptor.message_encrypt_a("020315", "not needed now")
    end
  end

 def test_message_encrypt_a_works_where_a_rotation_key_value_is_nil
   skip
   encryptor.stub :key, (nil) do
     assert_equal "y", encryptor.message_encrypt_a("020315", "not needed now")
   end
  end


  def test_message_encrypt_a_works_for_a_different_date
    skip
    encryptor.stub :key, ("41521") do
      assert_equal "y", encryptor.message_encrypt_a("220315", "not needed now")
    end
  end

  def test_message_encrypt_a_works_for_highest_possible_date_value_31
    skip
    encryptor.stub :key, ("41521") do
      assert_equal "y", encryptor.message_encrypt_a("310315", "not needed now")
    end
  end

  def test_message_encrypt_a_doesnt_work_for_date_values_greater_than_there_are_days_in_the_month_32
    skip
    encryptor.stub :key, ("41521") do
      assert_equal "y", encryptor.message_encrypt_a("320315", "not needed now")
    end
  end

  def test_message_encrypt_a_doesnt_work_for_date_values_less_than_there_are_days_in_the_month_00
    skip
    encryptor.stub :key, ("41521") do
      assert_equal "y", encryptor.message_encrypt_a("000315", "not needed now")
    end
  end

  def test_message_encrypt_a_doesnt_work_for_date_values_that_are_negative
    skip
    encryptor.stub :key, ("41521") do
      assert_equal "y", encryptor.message_encrypt_a("-020315", "not needed now")
    end
  end

 def test_message_encrypt_a_doesnt_work_for_date_values_that_are_nil
   skip
   encryptor.stub :key, ("41521") do
     assert_equal "y", encryptor.message_encrypt_a(nil, "not needed now")
   end
  end


  def test_message_encrypt_a_works_for_lowest_possible_rotation_date_value_01
    skip
    encryptor.stub :key, ("41521") do
      assert_equal "y", encryptor.message_encrypt_a("010315", "not needed now")
    end
  end

  def test_message_encrypt_a_works_where_a_rotation_key_value_is_less_than_10
    skip
    encryptor.stub :key, ("04521") do
      assert_equal "y", encryptor.message_encrypt_a("020315", "not needed now")
    end
  end

  def test_message_encrypt_a_works_for_highest_possible_rotation_key_of_value_99_and_last_unique_character_of_comma
    skip
    encryptor.stub :key, ("99521") do
      assert_equal "y", encryptor.message_encrypt_a("020315", ",not needed now")
    end
  end


  def test_message_encrypt_b_works
    skip
    encryptor.stub :key, ("41521") do
     assert_equal "i", encryptor.message_encrypt_b("020315", " not needed now")
    end
  end


end
