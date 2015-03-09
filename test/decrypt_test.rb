require 'simplecov'
SimpleCov.start

gem 'minitest', '~> 5.2'
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require_relative '../lib/decrypt'
require_relative '../lib/rotator'
require_relative '../lib/offset'

class DecryptTest < Minitest::Test
  attr_reader :decryptor, :rotator, :offset

  def setup
    @rotator = Rotator.new
    @decryptor = Decrypt.new(@rotator)
    @offset = Offset.new
  end

  def test_it_exists
    assert Decrypt
  end

  def test_index_position_map_returns_character_map_length
    assert_equal 155, decryptor.index_position_map.last
  end

  def test_message_only_contains_valid_characters
    assert_equal true, decryptor.invalid_message("$not")
  end

  def test_character_to_index_position_key_returns_correct_value
    assert_equal 2, decryptor.character_to_index_key(" ")
  end

  def test_a_offset_and_a_rotation_returns_number_of_positions_moved
    skip
    rotator.stub :a_rotation, (41) do
      assert_equal 50, decryptor.message_decrypt_a("020315", "not ", "41521")
    end
  end

  def test_char_index_key_and_a_rotation_and_offset_returns_correct_character_map_index_position
    skip
    rotator.stub :a_rotation, (41) do
      assert_equal 63, decryptor.message_decrypt_a("020315", "not ", "41521")
    end
  end

  def test_combine_number_of_positions_moved_and_message_returns_correct_value_aka_message_decrypt_a_works
    rotator.stub :a_rotation, (41) do
      assert_equal "c", decryptor.message_decrypt_a("020315", "not ", "41521")
    end
  end

  def test_message_decrypt_a_works_for_a_different_key
   rotator.stub :a_rotation, (87) do
     assert_equal "8", decryptor.message_decrypt_a("020315", "not ", "41521")
   end
  end

  def test_message_decrypt_a_works_for_highest_possible_rotation_key_of_value_99
    rotator.stub :a_rotation, (99) do
      assert_equal "w", decryptor.message_decrypt_a("020315", "not ", "41521")
    end
  end

  def test_message_decrypt_a_works_for_lowest_possible_rotation_key_of_value_00
    rotator.stub :a_rotation, (00) do
      assert_equal "e", decryptor.message_decrypt_a("020315", "not ", "41521")
    end
  end

  def test_message_decrypt_a_works_for_a_different_date
    rotator.stub :a_rotation, (41) do
      assert_equal "l", decryptor.message_decrypt_a("220388", "not ", "41521")
    end
  end

  def test_message_decrypt_a_works_for_lowest_possible_offset_value_0
    rotator.stub :a_rotation, (41) do
      assert_equal "l", decryptor.message_decrypt_a("010100", "not ", "41521")
    end
  end

  def test_message_decrypt_a_works_for_highest_possible_offset_value_9
    rotator.stub :a_rotation, (00) do
      assert_equal "e", decryptor.message_decrypt_a("020315", "not ", "41521")
    end
  end

  def test_message_decrypt_a_works_for_highest_possible_rotation_value_00_highest_possible_offset_value_0_and_first_unique_character_a
    rotator.stub :a_rotation, (00) do
      assert_equal "a", decryptor.message_decrypt_a("010100", "a not", "41521")
    end
  end

  def test_message_decrypt_a_works_for_highest_possible_rotation_value_99_highest_possible_offset_value_9_and_last_unique_character_of_comma
    rotator.stub :a_rotation, (99) do
      assert_equal "i", decryptor.message_decrypt_a("020315", ",not", "41521")
    end
  end

  def test_message_decrypt_b_works
    rotator.stub :b_rotation, (15) do
      assert_equal " ", decryptor.message_decrypt_b("020315", "not ", "41521")
    end
  end

  def test_message_decrypt_c_works
    rotator.stub :c_rotation, (52) do
      assert_equal "e", decryptor.message_decrypt_c("020315", "not ", "41521")
    end
  end

  def test_message_decrypt_d_works
    rotator.stub :d_rotation, (21) do
      assert_equal "k", decryptor.message_decrypt_d("020315", "not ", "41521")
    end
  end

  def test_first_four_characters_as_a_group_decrypts
    rotator.stub :a_rotation, (41) do
      rotator.stub :b_rotation, (15) do
        rotator.stub :c_rotation, (52) do
          rotator.stub :d_rotation, (21) do
            assert_equal ["c"," ","e","k"], decryptor.batch_decrypt("020315", "not ","41521")
          end
        end
      end
    end
  end

  def test_message_splits_into_four_char_arrays
    assert_equal "t.", decryptor.split_into_batches("what the what.")[-1]
  end

  def test_it_downcases
    assert_equal ["what", " the", " wha", "t."], decryptor.split_into_batches("wHaT ThE whAt.")
  end

  def test_it_returns_error_message_when_message_contains_invalid_character
     rotator.stub :a_rotation, (41) do
      rotator.stub :b_rotation, (15) do
        rotator.stub :c_rotation, (52) do
          rotator.stub :d_rotation, (21) do
            assert_equal "invalid character in message", decryptor.decrypt("020315", "7vm*w2mapvsx45m6p mfz3txv564l4m1m7m04os0pxt4","41521")
          end
        end
      end
    end
  end

  def test_can_decrypt_two_batches
    rotator.stub :a_rotation, (41) do
      rotator.stub :b_rotation, (15) do
        rotator.stub :c_rotation, (52) do
          rotator.stub :d_rotation, (21) do
            assert_equal "we all need to get some korean bbq at daegee", decryptor.decrypt("020315", "7vm0w2mapvsx45m6p mfz3txv564l4m1m7m04os0pxt4", "41521")
          end
        end
      end
    end
  end

end
