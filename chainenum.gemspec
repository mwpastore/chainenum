# frozen_string_literal: true
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = 'chainenum'
  spec.version       = '0.1.0'
  spec.authors       = ['Mike Pastore']
  spec.email         = ['mike@oobak.org']

  spec.summary       = 'Add #chain to enumerables, enumerators, and lazy enumerators'
  spec.homepage      = 'https://github.com/mwpastore/chainenum'
  spec.license       = 'MIT'

  spec.files         = %x{git ls-files -z}.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = %w[lib]

  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'rake', '~> 12.0'
  spec.add_development_dependency 'minitest', '~> 5.0'
end
