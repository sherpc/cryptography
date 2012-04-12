require "test/unit"
require "./main.rb"

class TestGeneratePrime < Test::Unit::TestCase
  def do_generate_prime_test n, expected
    assert_equal Integer.generate_prime(n), expected
  end

  def test_generate_prime
    cases = [
      [2, 2],
      [4, 5],
      [5, 5],
      [0, 2],
      [647826745720384570138457345, 647826745720384570138457353],
      [1356496849687316874361684231, 1356496849687316874361684241]
    ]
    cases.each { |test_case| do_generate_prime_test *test_case }
  end
end
