require_relative 'test_helper'

class DelegationTest < Minitest::Test
  
  def setup
    @foo = Foo.create!(name: 'Foo')
    @bars = []
    %w[one two three].each_with_index do |name, idx|
      @bars << @foo.bars.create!(name: name, number: idx + 1)
    end
    @other_bar = Bar.create!(name: 'Other Bar', number: 99)
    @bar_relation = Bar.where(id: [@bars.first.id, @other_bar.id])
    assert_equal 2, @bar_relation.count
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
  
  def test_assignment_of_relations_to_association_collections
    @foo.bars = @bar_relation
    assert_equal 2, @foo.bars.reload.count
    assert_nil @bars.second.reload.foo_id
    assert_nil @bars.third.reload.foo_id
  end
  
  def test_addition_of_relations_to_association_collections
    addition = @foo.bars + @bar_relation
    assert_equal 5, addition.size
  end
  
  def test_subtraction_of_relations_to_association_collections
    subtraction = @foo.bars - @bar_relation
    assert_equal 2, subtraction.size
  end
  
  def test_index_on_collection
    assert_equal 2, @foo.reload.bars.index(@bars[2])
  end
  
  def test_redelegation
    assert_raises(NoMethodError) { @foo.bars.sample.explain }
    assert_kind_of String, @foo.bars.sample(2).explain
  end
  
end
