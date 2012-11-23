# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "hipchat_nagios_notifier/version"

Gem::Specification.new do |s|
  s.name = "hipchat_nagios_notifier"
  s.version = HipchatNagiosNotifier::VERSION
  s.authors = ["James Golick"]
  s.email       = ["jamesgolick@gmail.com"]
  s.description = "HipChat nagios notifier."
  s.summary = "HipChat nagios notifier."
  s.homepage = "https://github.com/jamesgolick/hipchat_nagios_notifier"

  s.require_paths = ["lib"]

  s.rubyforge_project = "hipchat_nagios_notifier"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  s.add_development_dependency "bundler", ">= 1.0.0"

  s.add_runtime_dependency "hipchat-api"
  s.add_runtime_dependency "thor"
end
