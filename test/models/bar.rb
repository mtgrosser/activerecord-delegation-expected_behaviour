class Bar < ActiveRecord::Base
  belongs_to :foo
  
  class << self
    def lookup(name)
      find_by_name(name)
    end
    alias :[] :lookup
  end
  
end
