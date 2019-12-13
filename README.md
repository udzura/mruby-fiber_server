# mruby-fiber_server   [![Build Status](https://travis-ci.org/udzura/mruby-fiber_server.svg?branch=master)](https://travis-ci.org/udzura/mruby-fiber_server)
FiberServer class
## install by mrbgems
- add conf.gem line to `build_config.rb`

```ruby
MRuby::Build.new do |conf|

    # ... (snip) ...

    conf.gem :github => 'udzura/mruby-fiber_server'
end
```
## example
```ruby
p FiberServer.hi
#=> "hi!!"
t = FiberServer.new "hello"
p t.hello
#=> "hello"
p t.bye
#=> "hello bye"
```

## License
under the MIT License:
- see LICENSE file
