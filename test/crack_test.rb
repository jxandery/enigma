gem 'minitest', '~> 5.2'
require 'minitest/autorun'
require 'minitest/pride'
require '../lib/decrypt'
require '../lib/crack'

class CrackTest < Minitest::Test

  def test_it_exists
    assert Crack
  end

  # it's going to take in a message
  # it'll look at the last 7 characters
  # it'll use the current date and start the key at 00000
  # it'll run the decrypt algorithm until the last 7 characters == ..end..
  def test_it_decrypts_one_letter
    decrypt = Decrypt.new
    assert_equal "decrypted", decrypt.decrypting("090315", "")
  end

end
