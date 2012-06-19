require "test/unit"
require "./main.rb"

class TestArrayBitExtension < Test::Unit::TestCase
  def test_shift_left
    assert_equal [2,3,4,1], [1,2,3,4].shift_left
    assert_equal [3,4,1,2], [1,2,3,4].shift_left(2)
  end

  def test_shift_right
    assert_equal [4,1,2,3], [1,2,3,4].shift_right
    assert_equal [3,4,1,2], [1,2,3,4].shift_right(2)
  end

  def test_map_cell
    assert_equal [[2,4], [8,7]], [[1, 2], [3, 4]].map_cell([[1,2], [5,3]]) { |c1, c2| c1 + c2 }
    assert_equal [[2,3], [4,5]], [[1, 2], [3, 4]].map_cell { |c| c + 1 }
  end
end

