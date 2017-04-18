class Bar < ActiveRecord::Base
  belongs_to :foo
  
  class << self
    def lookup(name)
      find_by_name(name)
    end
    alias :[] :lookup
    
    def sample(n = 1, random: nil)
      relation = order('RANDOM()').limit(n || 1)
      1 == n ? relation.first : relation
    end
  end
  
end
