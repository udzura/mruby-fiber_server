MRuby::Gem::Specification.new('mruby-fiber_server') do |spec|

  spec.license = 'MIT'
  spec.authors = 'Uchio Kondo'

  spec.add_dependency 'mruby-io', core: 'mruby-io'
  spec.add_dependency 'mruby-socket', core: 'mruby-socket'
  spec.add_dependency 'mruby-errno', mgem: 'mruby-errno'
  spec.add_dependency 'mruby-fibered_worker', github: 'udzura/mruby-fibered_worker'
end
