require 'simplecov'
SimpleCov.start

gem 'minitest', '~> 5.2'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/decrypt'
require_relative '../lib/encrypt'
require_relative '../lib/crack'

class CrackTest < Minitest::Test
  attr_reader :crack, :encryptor, :decryptor

  def setup
    @crack = Crack.new
    @encryptor = Encrypt.new
    @decryptor = Decrypt.new
  end

  def test_it_exists
    assert Crack
  end

  def test_it_can_capture_the_last_elements_of_a_string
    assert_equal "ppy day", crack.last_seven("oh, happy day")
  end

  def test_it_can_figure_out_when_decoder_starts_on_rotation_a
    skip
    assert_equal "p", crack.starting_point("oh, happy day")
  end

  # it's going to take in a message
  # it'll look at the last 7 characters
  # it'll use the current date and start the key at 00000
  # it'll run the decrypt algorithm until the last 7 characters == ..end..

  # the index position, rotation and message looks like the following
  # 0 1 2 3 4 5 6
  # . . e n d . .
  # a b c d a b c
  def test_it_encrypts_the_decoder
    encryptor.stub :key, ("41521") do
      assert_equal "jptaopn", encryptor.encrypt("020315", "..end..")
    end
  end

  def test_it_decrypts_the_encrypted_decoder_message_with_same_date_and_key
    assert_equal "..end..", decryptor.decrypt("20315", "jptaopn", "41521")
  end

  def test_it_collects_all_the_index_positions_for_period_in_the_a_position
    assert_equal [1, 40, 79, 118], crack.index_positions(".")
  end

  def test_it_collects_all_the_index_positions_for_first_char_in_the_encrypted_message
    assert_equal [29, 68, 107, 146], crack.index_positions("j")
  end

  def test_it_uses_the_date_and_adds_the_a_offset
    assert_equal 38, crack.reverse_shift("020315", "j")
  end

  def test_it_subtracts_revers_shift_from_potential_index_position_of_decoder_in_a
    skip
    assert_equal [-37, 2, 41, 81], crack.possible_rotations("020315", "j", ".")
  end

end
