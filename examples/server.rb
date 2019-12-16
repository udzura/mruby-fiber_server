nr = (ARGV[0] || 10).to_i
$shutdown = false
sock = TCPServer.new 8880
def spawn(sock)
  Process.fork do
    FiberServer.sigpipe_ign!
    loop do
      client = sock.accept
      t = Time.now.to_f
      headers = ""
      readloop = true
      err = nil
      while readloop do
        header = ""
        begin
          header = client.sysread(2048)
          # p "Got: #{header.inspect}"
        rescue => e
          err = e
          readloop = false
        end
        headers << header
        break if header.end_with?("\r\n\r\n")
      end
      p headers.split("\r\n")
      begin
        if err
          client.syswrite "HTTP/1.1 503 Service Unavailable\r\n"
          client.syswrite "Content-Type: text/plain\r\n"
          client.syswrite "\r\n"
          client.syswrite "#{err.inspect}\n"
        else
          client.syswrite "HTTP/1.1 200 OK\r\n"
          client.syswrite "Content-Type: text/plain\r\n"
          client.syswrite "\r\n"
          client.syswrite "mruby httpd!\n"
        end
      rescue => e
        p e
        puts "Then ignore"
      end
      client.close rescue nil
      puts "Elapsed: #{Time.now.to_f - t}"
    end
  end
end

workers = (1..nr).map do |i|
  spawn(sock)
end

loop = FiberedWorker::MainLoop.new
loop.pids = workers
def shutdown(sig, workers)
  puts "Receive sig: #{sig}"
  $shutdown = true
  workers.each do |worker|
    Process.kill :TERM, worker
  end
end

loop.register_handler(:INT) {|n| shutdown(n, workers) }
loop.register_handler(:TERM) {|n| shutdown(n, workers) }
loop.register_handler(:HUP) {|n| shutdown(n, workers) }

loop.on_worker_exit do |s, r|
  puts "Dead: #{s}, rest process: #{r.inspect}"

  if !$shutdown && (s.to_i & 0b11111111)== 13
    new_pid = spawn(sock)
    puts "Respawn #{new_pid}"
    loop.pids << new_pid
  end
end

puts "[#{$$}] Starting server http://localhost:8880/ with #{nr} worker(s)"
p loop.run
