# coding: utf-8

require "net/http"
require "uri"
require "json"

$LOAD_PATH.unshift(File.expand_path("../", __FILE__))
require "megalopolis/version"
require "megalopolis/essentials"
require "megalopolis/scheme"

class Megalopolis
  attr_accessor :base_url
  USER_AGENT = "Megalopolis Ruby Wrapper #{Megalopolis::VERSION}"

  def initialize(base_url)
    @base_url = base_url
  end
  
  def get(args={})
    args[:log] ||= 0
    if args.has_key?(:key)
      Novel.new(@base_url, args[:log], args[:key])
    else
      Subject.new(@base_url, args[:log])
    end
  end

  #def search(query, args={})
  #  page = send_req(File.join(@base_url, "search.json?query=#{query}"))
  #  parse_index(page)
  #end
end
