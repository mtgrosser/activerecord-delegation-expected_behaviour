class Foo < ActiveRecord::Base
  has_many :bars
  
  has_many :extended_bars, class_name: 'Bar' do
    def [](extended_name)
      lookup(extended_name.to_s.sub(/_ext\z/, ''))
    end
    
    def hello
      'world'
    end
  end
end
