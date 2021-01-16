$:.unshift File.join(File.dirname(__FILE__), 'lib')
require 'kuby/bare-metal/version'

Gem::Specification.new do |s|
  s.name     = 'kuby-bare-metal'
  s.version  = ::Kuby::BareMetal::VERSION
  s.authors  = ['Mathias Kaufmann']
  s.email    = ['steigr@me.com']
  s.homepage = 'http://github.com/steigr/kuby-bare-metal'

  s.description = s.summary = 'Bare metal provider for Kuby.'

  s.platform = Gem::Platform::RUBY

  s.add_dependency 'kube-dsl', '~> 0.1'

  s.require_path = 'lib'
  s.files = Dir['{lib,spec}/**/*', 'Gemfile', 'LICENSE', 'CHANGELOG.md', 'README.md', 'Rakefile', 'kuby-bare-metal.gemspec']
end
