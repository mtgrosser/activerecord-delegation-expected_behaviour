Gem::Specification.new do |s|
  s.name          = 'activerecord-delegation-expected_behaviour'
  s.version       = '1.6.0'
  s.authors       = ['Matthias Grosser']
  s.email         = ['mtgrosser@gmx.net']
  s.date          = '2023-05-17'
  
  s.summary       = %q{Prefer some class methods over methods from Enumerable on relations}
  s.description   = %q{Since Rails 5 you can no longer call some ActiveRecord class methods named like their Enumerable counterparts. This gem reinstates the expected behaviour, where you can always get the method from Enumerable by calling to_a on the relation.}
  s.homepage      = 'https://github.com/mtgrosser/activerecord-delegation-expected_behaviour'
  s.licenses      = ['MIT']
  
  s.files         = Dir['{lib}/**/*.rb', 'LICENSE', 'README.md', 'CHANGELOG', 'Rakefile']
  
  s.require_paths = ['lib']

  s.add_dependency 'activerecord', '~> 7.0.0'

  s.add_development_dependency 'bundler'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'minitest'
  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'simplecov'
  s.add_development_dependency 'byebug'
end
