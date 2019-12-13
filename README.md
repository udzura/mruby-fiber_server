# mruby-fiber_server

Sample multi prefork worker HTTPD using pure(?) mruby.

## Try it

```
$ rake
$ ./mruby/bin/mruby examples/server.rb 

---
$ ab -c20 -t30 -n10000000 http://localhost:8880/
```

## License
under the MIT License:
- see LICENSE file
