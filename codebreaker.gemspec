# coding: utf-8

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'codebreaker/version'

Gem::Specification.new do |spec|
  spec.name          = 'codebreaker'
  spec.version       = Codebreaker::VERSION
  spec.authors       = ['Eugene']
  spec.email         = ['Re4port@ukr.net']

  spec.summary       = %q{Codebreaker is a logic game in which a code-breaker tries
                          to break a secret code created by a code-maker.}
  spec.description   = %q{Codebreaker is a logic game in which a code-breaker tries
                          to break a secret code created by a code-maker.
                          The code-maker, which will be played by the application we’re going to write,
                          creates a secret code of four numbers between 1 and 6.
                          The code-breaker then gets some number of chances to break the code.
                          In each turn, the code-breaker makes a guess of four numbers.
                          The code-maker then marks the guess with up to four + and - signs.}
  spec.homepage      = "TODO: Put your gem's website or public repo URL here."
  spec.license       = 'MIT'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise 'RubyGems 2.0 or newer is required to protect against ' \
      'public gem pushes.'
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.15'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.5'
end
