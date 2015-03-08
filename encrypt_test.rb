require 'simplecov'
SimpleCov.start

gem 'minitest', '~> 5.2'
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require './encrypt'

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
    skip skip
    offset = Offset.new
    assert_equal String, offset.date_key.class
  end

  def test_date_input_is_a_fixnum_when_converted_to_integer
    skip skip
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

class EncryptTest < Minitest::Test
  attr_reader :encryptor, :rotator, :offset

  def setup
    @rotator = Rotator.new
    @encryptor = Encrypt.new(@rotator)
    @offset = Offset.new
  end

  def test_it_exists
    assert Encrypt
  end

  def test_index_position_map_returns_character_map_length
    assert_equal 155, encryptor.index_position_map.last
  end

  def test_message_only_contains_valid_characters
     assert_equal "invalid character in message", encryptor.invalidate_message("$not")
  end

  def test_character_to_index_position_key_returns_correct_value
    assert_equal 2, encryptor.character_to_index_key("c")
  end

  def test_a_offset_and_a_rotation_returns_number_of_positions_moved
    skip
    rotator.stub :a_rotation, ("41521") do
      assert_equal 50, encryptor.message_encrypt_a("020315", "not ")
    end
  end

  def test_char_index_key_and_a_rotation_and_offset_returns_correct_character_map_index_position
    skip
    rotator.stub :a_rotation, ("41521") do
      assert_equal 63, encryptor.message_encrypt_a("020315", "not ")
    end
  end

  def test_combine_number_of_positions_moved_and_message_returns_correct_value_aka_message_encrypt_a_works
    rotator.stub :a_rotation, (41) do
      assert_equal "y", encryptor.message_encrypt_a("020315", "not ")
    end
  end

  def test_message_encrypt_a_works_for_a_different_key
   rotator.stub :a_rotation, (87) do
     assert_equal 5, encryptor.message_encrypt_a("020315", "not ")
   end
  end

  def test_message_encrypt_a_works_for_highest_possible_rotation_key_of_value_99
    rotator.stub :a_rotation, (99) do
      assert_equal "e", encryptor.message_encrypt_a("020315", "not ")
    end
  end

  def test_message_encrypt_a_works_for_lowest_possible_rotation_key_of_value_00
    rotator.stub :a_rotation, (00) do
      assert_equal "w", encryptor.message_encrypt_a("020315", "not ")
    end
  end

  def test_message_encrypt_a_works_for_a_different_date
    rotator.stub :a_rotation, (41) do
      assert_equal "p", encryptor.message_encrypt_a("220388", "not ")
    end
  end

  def test_message_encrypt_a_works_for_lowest_possible_offset_value_0
    rotator.stub :a_rotation, (41) do
      assert_equal "p", encryptor.message_encrypt_a("010100", "not ")
    end
  end

  def test_message_encrypt_a_works_for_highest_possible_offset_value_9
    rotator.stub :a_rotation, (00) do
      assert_equal "w", encryptor.message_encrypt_a("020315", "not ")
    end
  end

  def test_message_encrypt_a_works_for_highest_possible_rotation_value_00_highest_possible_offset_value_0_and_first_unique_character_a
    rotator.stub :a_rotation, (00) do
      assert_equal "a", encryptor.message_encrypt_a("010100", "a not")
    end
  end

  def test_message_encrypt_a_works_for_highest_possible_rotation_value_99_highest_possible_offset_value_9_and_last_unique_character_of_comma
    rotator.stub :a_rotation, (99) do
      assert_equal 3, encryptor.message_encrypt_a("020315", ",not")
    end
  end

  def test_message_encrypt_b_works
    rotator.stub :b_rotation, (15) do
      assert_equal 5, encryptor.message_encrypt_b("020315", "not ")
    end
  end

  def test_message_encrypt_c_works
    rotator.stub :c_rotation, (52) do
      assert_equal 8, encryptor.message_encrypt_c("020315", "not ")
    end
  end

  def test_message_encrypt_d_works
    rotator.stub :d_rotation, (21) do
      assert_equal "x", encryptor.message_encrypt_d("020315", "not ")
    end
  end

  def test_first_four_characters_as_a_group_encrypts
    rotator.stub :a_rotation, (41) do
      rotator.stub :b_rotation, (15) do
        rotator.stub :c_rotation, (52) do
          rotator.stub :d_rotation, (21) do
            assert_equal ["y",5,8,"x"], encryptor.batch_encrypt("020315", "not ")
          end
        end
      end
    end
  end

  def test_message_splits_into_four_char_arrays
    assert_equal "t.", encryptor.split_into_batches("what the what.")[-1]
  end

  def test_can_encrypt_two_batches
    rotator.stub :a_rotation, (41) do
      rotator.stub :b_rotation, (15) do
        rotator.stub :c_rotation, (52) do
          rotator.stub :d_rotation, (21) do
            assert_equal "yvt3y58x", encryptor.encrypting("020315", "neednot ")
          end
        end
      end
    end
  end

end
