# -*- encoding: utf-8 -*-
# stub: acts_as_follower 0.2.1 ruby lib

Gem::Specification.new do |s|
  s.name = "acts_as_follower".freeze
  s.version = "0.2.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Tom Cocca".freeze]
  s.date = "2013-12-05"
  s.description = "acts_as_follower is a Rubygem to allow any model to follow any other model. This is accomplished through a double polymorphic relationship on the Follow model. There is also built in support for blocking/un-blocking follow records. Main uses would be for Users to follow other Users or for Users to follow Books, etc\u2026 (Basically, to develop the type of follow system that GitHub has)".freeze
  s.email = ["tom dot cocca at gmail dot com".freeze]
  s.homepage = "https://github.com/tcocca/acts_as_follower".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.2.33".freeze
  s.summary = "A Rubygem to add Follow functionality for ActiveRecord models".freeze

  s.installed_by_version = "3.2.33" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 3
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_development_dependency(%q<sqlite3>.freeze, [">= 0"])
    s.add_development_dependency(%q<shoulda_create>.freeze, [">= 0"])
    s.add_development_dependency(%q<shoulda>.freeze, [">= 3.5.0"])
    s.add_development_dependency(%q<factory_girl>.freeze, [">= 4.2.0"])
    s.add_development_dependency(%q<rails>.freeze, ["~> 4.0.0"])
  else
    s.add_dependency(%q<sqlite3>.freeze, [">= 0"])
    s.add_dependency(%q<shoulda_create>.freeze, [">= 0"])
    s.add_dependency(%q<shoulda>.freeze, [">= 3.5.0"])
    s.add_dependency(%q<factory_girl>.freeze, [">= 4.2.0"])
    s.add_dependency(%q<rails>.freeze, ["~> 4.0.0"])
  end
end
