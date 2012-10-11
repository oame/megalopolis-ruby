class Megalopolis
  module Essentials
    def param_serialize(parameter, add_prefix=true)
      return "" unless parameter.class == Hash
      ant = Hash.new
      parameter.each do |key, value|
        ant[key.to_sym] = value.to_s
      end
      param = ant.inject(""){|k,v|k+"&#{v[0]}=#{URI.escape(v[1])}"}
      if add_prefix
        param.sub!(/^&/,"?") 
      else
        param.sub!(/^&/,"") 
      end
      return param ? param : ""
    end

    def send_req(url)
      uri = URI.parse(url)

      Net::HTTP.version_1_2
      Net::HTTP.start(uri.host, uri.port) do |http|
        response = http.get(uri.path, 'User-Agent' => USER_AGENT)
        return response.body
      end
      return false
    end
  end
end