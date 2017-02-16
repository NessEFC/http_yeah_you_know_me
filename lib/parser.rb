require 'pry'

class Parser
  attr_reader :verb, :path, :protocol, :host, :port, :origin, :accept
  attr_accessor :request, :response

  def initialize(request)
    @request = request
    @response = response
  end

  # FOR TEST CASE PURPOSES, USE THE REQUEST INFO BELOW
  #
  #  request_lines from Postman:
  # request_lines = ["GET / HTTP/1.1",
  #  "Host: 127.0.0.1:9292",
  #  "Connection: keep-alive",
  #  "Cache-Control: no-cache",
  #  "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/55.0.2883.95 Safari/537.36",
  #  "Postman-Token: 50f30dbc-7d7d-e86e-f0a1-4fdca1d58c42",
  #  "Accept: */*",
  #  "Accept-Encoding: gzip, deflate, sdch, br",
  #  "Accept-Language: en-US,en;q=0.8"]
  #
  #  request_lines from Chrome browser:
  # request_lines = ["GET / HTTP/1.1",
  #   "Host: 127.0.0.1:9292",
  #   "Connection: keep-alive",
  #   "Upgrade-Insecure-Requests: 1",
  #   "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/55.0.2883.95 Safari/537.36",
  #   "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8",
  #   "Accept-Encoding: gzip, deflate, sdch, br",
  #   "Accept-Language: en-US,en;q=0.8"]



  def output
  # Refactor opportunity--figure out loop for this:
  header_1 = request[0].split(" ")
  @verb = header_1[0]
  @path = header_1[1]
  @protocol = header_1[2]

  header_2 = request[1].split(" ")
  @host = header_2[1].split(":")[0]
  @port = header_2[1].split(":")[1]

  @origin = host
  @accept = request[-3].split(": ")[1]
  format_response(verb, path, protocol, host, port, origin, accept)
  end


  def format_response(verb, path, protocol, host, port, origin, accept)
    @response = "<pre>" + "\nVerb: #{verb}\n" + "Path: #{path}\n" + "Protocol: #{protocol}\n" + "Host: #{host}\n" + "Port: #{port}\n" + "Origin: #{origin}\n" + "Accept: #{accept}\n" + "</pre>"
  end

end
