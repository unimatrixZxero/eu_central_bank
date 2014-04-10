#!/bin/env ruby
# encoding: utf-8
Gem::Specification.new do |s|
  s.name         = "offline_bank"
  s.version      = "0.0.1"
  s.platform     = Gem::Platform::RUBY
  s.authors      = ["Wong Liang Zan", "Shane Emmons", "Thorsten Böttger", "Jonathan Eisenstein", "Sam Figueroa"]
  s.email        = ["unimatrixzxero@gmail.com"]
  s.homepage     = "http://github.com/unimatrixzxero/offline_bank"
  s.summary      = "Calculates exchange rates based on cached rates. Money gem compatible."
  s.description  = "This gem reads exchange rates from a cached file for offline use of the money gem."

  s.required_rubygems_version = ">= 1.3.6"

  s.add_dependency "nokogiri"
  s.add_dependency "money", ">= 6.0.1"

  s.add_development_dependency "rspec", ">= 2.0.0"
  s.add_development_dependency "rr"
  s.add_development_dependency "minitest"
  s.add_development_dependency "shoulda"

  s.files         = Dir.glob("lib/**/*") + %w(CHANGELOG.md LICENSE README.md)
  s.require_path = "lib"
end
