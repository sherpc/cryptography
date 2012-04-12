require "test/unit"
require "./main.rb"

class TestGeneratePrime < Test::Unit::TestCase
  def do_is_prime_test n, expected
    assert_equal n.prime?, expected
  end

  def test_is_prime
    cases = [
      [1, false],
      [2, true],
      [3, true],
      [6, false],
      [647826745720384570138457353, true],
      [1356496849687316874361684231, false]
    ]
    cases.each { |test_case| do_is_prime_test *test_case }
  end

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

  def do_witness_test n, a, expected
    assert_equal n.witness?(a), expected
  end

  def test_witness
    cases = [
      [5, 2, false],
      [9, 3, true],
      [9, 2, true]
    ]
    cases.each { |test_case| do_witness_test *test_case }
  end
end
