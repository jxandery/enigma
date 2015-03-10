require 'simplecov'
SimpleCov.start

gem 'minitest', '~> 5.2'
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require_relative '../lib/encrypt'
require_relative '../lib/rotator'
require_relative '../lib/offset'

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
     assert_equal true, encryptor.invalid_message("$not")
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

  def test_combine_number_of_positions_moved_and_message_returns_correct_value_aka_message_encrypt_a_works_with_key_stubbed
    # this might be where it's fucked up
    # once encrypted, it doesn't seem to be decrypting back to the same message
    # a_rotation was stubbed out, so the tests are passing
    # but that doesn't mean it is reading the keys correctly, so
    # try stubbing the key. that may identify the problem
    #
    encryptor.stub :key, ("41521") do
      assert_equal "y", encryptor.message_encrypt_a("020315", "not ")
    end
  end

  def test_combine_number_of_positions_moved_and_message_returns_correct_value_aka_message_encrypt_a_works
    rotator.stub :a_rotation, (41) do
      assert_equal "y", encryptor.message_encrypt_a("020315", "not ")
    end
  end

  def test_message_encrypt_a_works_for_a_different_key
   rotator.stub :a_rotation, (87) do
     assert_equal "5", encryptor.message_encrypt_a("020315", "not ")
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
      assert_equal "3", encryptor.message_encrypt_a("020315", ",not")
    end
  end

  def test_message_encrypt_b_works
    rotator.stub :b_rotation, (15) do
      assert_equal "5", encryptor.message_encrypt_b("020315", "not ")
    end
  end

  def test_message_encrypt_c_works
    rotator.stub :c_rotation, (52) do
      assert_equal "8", encryptor.message_encrypt_c("020315", "not ")
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
            assert_equal ["y","5","8","x"], encryptor.batch_encrypt("020315", "not ")
          end
        end
      end
    end
  end

  def test_message_splits_into_four_char_arrays
    assert_equal "t.", encryptor.split_into_batches("what the what.")[-1]
  end

  def test_it_downcases
    assert_equal ["what", " the", " wha", "t."], encryptor.split_into_batches("wHaT ThE whAt.")
  end

  def test_can_encrypt_two_batches
    rotator.stub :a_rotation, (41) do
      rotator.stub :b_rotation, (15) do
        rotator.stub :c_rotation, (52) do
          rotator.stub :d_rotation, (21) do
            assert_equal "7vm0w2mapvsx45m6p mfz3txv564l4m1m7m04os0pxt4", encryptor.encrypting("020315", "We all need to get some Korean BBQ at Daegee")
          end
        end
      end
    end
  end

  def test_it_encrypts_inside_an_if_statement
    rotator.stub :a_rotation, (41) do
      rotator.stub :b_rotation, (15) do
        rotator.stub :c_rotation, (52) do
          rotator.stub :d_rotation, (21) do
            assert_equal "7vm0w2mapvsx45m6p mfz3txv564l4m1m7m04os0pxt4", encryptor.encrypt("020315", "We all need to get some Korean BBQ at Daegee")
          end
        end
      end
    end
  end

  def test_it_returns_invalid_message_character_check_elevated
    rotator.stub :a_rotation, (41) do
      rotator.stub :b_rotation, (15) do
        rotator.stub :c_rotation, (52) do
          rotator.stub :d_rotation, (21) do
            assert_equal "invalid character in message", encryptor.encrypt("020315", "We all need to get some Korean BBQ at Daegee!")
          end
        end
      end
    end
  end

  def test_it_returns_encrypted_message_with_key_stubbed
    encryptor.stub :key, ("41521") do
      assert_equal "y", encryptor.encrypt("020315", "why are you not working")
    end
  end

  def test_it_returns_encrypted_message_with_key_stubbed_and_ends_with_decoder_ring
    encryptor.stub :key, ("41521") do
      assert_equal "y", encryptor.encrypt("020315", "oh, happy day ..end..")
    end
  end

end
