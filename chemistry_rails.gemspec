Gem::Specification.new do |s|
  s.name        = 'chemistry_rails'
  s.version     = '0.1.7'
  s.date        = '2014-06-16'
  s.summary     = "Chemistry rails"
  s.description = "A gem for validating chemical formula and calculating elemental analysis"
  s.authors     = ["Radil Radenkov"]
  s.email       = 'radil@chem.io'
  s.files       = ["lib/chemistry_rails.rb", "lib/chemistry_rails/orm/activerecord.rb", "lib/chemistry_rails/locale/en.yml"]
  s.homepage    = 'https://github.com/CHEMIO/chemistry_rails'
  s.license     = 'MIT'

  s.add_development_dependency 'rake'
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'rails', '>= 3.2.0'
end