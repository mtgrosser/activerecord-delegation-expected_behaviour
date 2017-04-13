require_relative 'test_helper'

class DelegationTest < Minitest::Test
  
  def setup
    @foo = Foo.create!(name: 'Foo')
    %w[one two three].each_with_index do |name, idx|
      @foo.bars.create!(name: name, number: idx + 1)
    end
  end

  def test_class_methods_override_enumerable_methods
    assert_equal 1, @foo.bars['one'].number
    assert_equal 2, @foo.bars['two'].number
    assert_equal 3, @foo.bars['three'].number
  end
  
  def test_enumerable_methods_can_be_accessed_by_calling_to_a
    assert_equal 1, @foo.bars.to_a[0].number
    assert_equal 2, @foo.bars.to_a[1].number
    assert_equal 3, @foo.bars.to_a[2].number
    assert_raises(TypeError) { @foo.bars.to_a['one'] }
  end
  
end
