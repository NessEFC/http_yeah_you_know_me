require 'pry'
require 'socket'
require './lib/parser'

class Server
  attr_reader :tcp_server, :client
  attr_accessor :hello_counter, :total_counter

  def initialize(port)
    @tcp_server = TCPServer.new(port)
    @hello_counter = 0
    @total_counter = 0
    @client = client
  end

  def read_request
    puts "Ready for a request"
    @client = tcp_server.accept
    @total_counter += 1

    request_lines = []
    while line = client.gets and !line.chomp.empty?
      request_lines << line.chomp
    end
    request_lines
  end

  def format_output(output)
    headers = ["http/1.1 200 ok",
              "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
              "server: ruby",
              "content-type: text/html; charset=iso-8859-1",
              "content-length: #{output.length}\r\n\r\n"].join("\r\n")
    client.puts headers
    client.puts output

    puts ["Wrote this response:\n", headers, output].join("\n")
    puts "\nResponse complete."
  end

  def determine_path(request_lines)
    parser = Parser.new(request_lines)
    parser.output

    if parser.path == "/"
      output = "<html><head></head><body>#{parser.output}</body></html>"
    elsif parser.path == "/hello"
      @hello_counter += 1
      output = "<html><head></head><body>Hello, World! (#{hello_counter})</body></html>"
    elsif parser.path == "/datetime"
      output = "#{Time.now.strftime('%l:%M%p on %A, %B %e, %Y')}"
    elsif parser.path == "/shutdown"
      output = "Total Requests: #{total_counter}"
      format_output(output)
      puts "\nShutting down server."
      client.close
    end
    format_output(output)
  end

  def response
    loop do
      request_lines = read_request
      puts "\nSending response...\n\n"
      determine_path(request_lines)
    end
  end

end


server = Server.new(9292)
server.response
