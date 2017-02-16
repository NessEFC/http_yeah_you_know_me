require 'pry'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/server'

class ServerTest < Minitest::Test
  attr_reader :request_lines

  def setup
    @request_lines = ["GET / HTTP/1.1",
     "Host: 127.0.0.1:9292",
     "Connection: keep-alive",
     "Cache-Control: no-cache",
     "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/55.0.2883.95 Safari/537.36",
     "Postman-Token: 50f30dbc-7d7d-e86e-f0a1-4fdca1d58c42",
     "Accept: */*",
     "Accept-Encoding: gzip, deflate, sdch, br",
     "Accept-Language: en-US,en;q=0.8"]
  end

  def test_parser_returns_output
    skip
    server = Server.new(9292)
    assert_equal "<pre>\nVerb: GET\nPath: /\nProtocol: HTTP/1.1\nHost: 127.0.0.1\nPort: 9292\nOrigin: 127.0.0.1\nAccept: */*\n</pre>", parser.output
  end

end
