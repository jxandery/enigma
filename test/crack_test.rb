gem 'minitest', '~> 5.2'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/decrypt'
require_relative '../lib/crack'

class CrackTest < Minitest::Test
  attr_reader :crack

  def setup
    @crack = Crack.new
  end

  def test_it_exists
    assert Crack
  end

  def test_it_can_capture_the_last_elements_of_a_string
    assert_equal "ppy day", crack.last_seven("oh, happy day")
  end

  def test_it_can_figure_out_when_decoder_starts_on_rotation_a
    assert_equal "p", crack.starting_point("oh, happy day")
  end

  # it's going to take in a message
  # it'll look at the last 7 characters
  # it'll use the current date and start the key at 00000
  # it'll run the decrypt algorithm until the last 7 characters == ..end..
  def test_it_decrypts_one_letter
    skip
    decrypt = Decrypt.new
    assert_equal "", decrypt.decrypt("090315", "g")
  end

end
