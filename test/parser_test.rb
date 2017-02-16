require 'pry'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/parser'

class ParserTest < Minitest::Test
  attr_reader :parser

  def setup
    @parser = Parser.new(["GET / HTTP/1.1",
     "Host: 127.0.0.1:9292",
     "Connection: keep-alive",
     "Cache-Control: no-cache",
     "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/55.0.2883.95 Safari/537.36",
     "Postman-Token: 50f30dbc-7d7d-e86e-f0a1-4fdca1d58c42",
     "Accept: */*",
     "Accept-Encoding: gzip, deflate, sdch, br",
     "Accept-Language: en-US,en;q=0.8"])
  end

  def test_parser_exists
    assert_instance_of Parser, parser
  end

  def test_parser_extracts_verb
    parser.output
    assert_equal "GET", parser.verb
  end

  def test_parser_extracts_path
    parser.output
    assert_equal "/", parser.path
  end

  def test_parser_extracts_protocol
    parser.output
    assert_equal "HTTP/1.1", parser.protocol
  end

  def test_parser_extracts_host
    parser.output
    assert_equal "127.0.0.1", parser.host
  end

  def test_parser_extracts_port
    parser.output
    assert_equal "9292", parser.port
  end

  def test_parser_extracts_origin
    parser.output
    assert_equal "127.0.0.1", parser.origin
  end

  def test_parser_extracts_accept
    parser.output
    assert_equal "*/*", parser.accept
  end

  def test_parser_formats_correctly
    assert_equal "<pre>\nVerb: GET\nPath: /\nProtocol: HTTP/1.1\nHost: 127.0.0.1\nPort: 9292\nOrigin: 127.0.0.1\nAccept: */*\n</pre>", parser.output
  end

end
