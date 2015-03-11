require 'simplecov'
SimpleCov.start

gem 'minitest', '~> 5.2'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/decrypt'
require_relative '../lib/encrypt'
require_relative '../lib/crack_back_up'


class CrackBackUpTest < Minitest::Test

  def test_can_decrypt_with_messages_the_end_at_the_end
    skip
    cracker = CrackBackUp.new
    assert_equal "..end...", cracker.crack("20315", "jptaopn")
  end

end
