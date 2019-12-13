##
## FiberServer Test
##

assert("FiberServer#hello") do
  t = FiberServer.new "hello"
  assert_equal("hello", t.hello)
end

assert("FiberServer#bye") do
  t = FiberServer.new "hello"
  assert_equal("hello bye", t.bye)
end

assert("FiberServer.hi") do
  assert_equal("hi!!", FiberServer.hi)
end
