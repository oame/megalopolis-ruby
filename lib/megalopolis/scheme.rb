# coding: utf-8

class Hash2 < Hash
  attr_accessor :hash

  def initialize(hash)
    super(hash)
    @hash = hash
  end

  def method_missing(action, *args)
    return @hash[action.to_s] rescue nil
  end

  def params() @hash.keys.map{|k|k.to_sym} ; end

  def to_hash
    @hash
  end
end

class Megalopolis
  class Novel
    include Essentials
    attr_reader :novel
    attr_reader :base_url
    attr_reader :log
    attr_reader :id

    def initialize(base_url, log, id)
      @novel = fetch_novel(base_url, log, id)
      @base_url = base_url
      @log = log
      @id = id
    end
    
    def fetch_novel(base_url, log, id)
      page = send_req(File.join(base_url, log.to_s, "#{id}.json"))
      novel = JSON.parse(page)
      novel["url"] = URI.join(base_url, "#{log}/#{id}").to_s
      return novel
    end
    
    def simple_rating(point)
      get_params = param_serialize({:point => point})
      uri = URI.parse(@base_url)
      Net::HTTP.start(uri.host, uri.port) do |http|
        header = { "User-Agent" => USER_AGENT }
        response = http.post(uri.path, get_param, header)
      end
    end
    
    def comment(text, params={})
      get_params = param_serialize(params)
      uri = URI.parse(@base_url)
      Net::HTTP.start(uri.host, uri.port) do |http|
        header = { "User-Agent" => USER_AGENT }
        response = http.post(uri.path, get_param, header)
      end
    end
    
    def plain
      return self.body.gsub(/(<br>|\r?\n)/, "")
    end

    def method_missing(action, *args)
      return Hash2.new(@novel[action.to_s]) rescue nil
    end
    
    def params() @novel.keys.map{|k|k.to_sym} ; end
    alias_method :available_methods, :params
    
    def to_hash
      @novel
    end
  end
  
  class Index
    attr_reader :base_url
    attr_reader :index

    def initialize(base_url, index)
      @base_url = base_url
      @index = index
    end

    def method_missing(action, *args)
      return @index[action.to_s] rescue nil
    end
    
    def params() @index.keys.map{|k|k.to_sym} ; end
    
    def to_hash
      @index
    end

    def fetch
      Novel.new(@base_url, self.log, self.id)
    end
    alias_method :get, :fetch
  end

  class Subject < Array
    include Essentials
    attr_reader :log
    attr_reader :subject
    attr_reader :base_url
    
    def initialize(base_url, log)
      @subject = fetch_subject(base_url, log)
      super(subject)
      @base_url = base_url
      @log = log
    end

    def fetch_subject(base_url, log)
      page = send_req(File.join(base_url, "#{log}.json"))
      obj = JSON.parse(page)["entries"]

      indexes = []
      obj.each do |index|
        index["url"] = URI.join(base_url, "#{log}/#{index["id"]}").to_s
        index["log"] = index["subject"]
        index.delete("subject")
        indexes << Index.new(base_url, index)
      end
      return indexes.reverse
    end

    def next_page
      Subject.new(@base_url, @log-1)
    end
    alias_method :next, :next_page

    def prev_page
      Subject.new(@base_url, @log+1)
    end
    alias_method :prev, :prev_page
    
    def latest_log
      page = send_req(File.join(base_url, "0.json"))
      return JSON.parse(page)["entries"][0]["subject"]
    end
  end
end