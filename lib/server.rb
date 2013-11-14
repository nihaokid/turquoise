class Server
  def self.draw(&block)
    server = Server.new
    server.instance_eval(&block)
    server
  end

  %w{ get post put }.each do |method|
    define_method(method) do |uri, &block|
      @handlers[method] ||= []
      @handlers[method] << {:uri => URIHandler.new(uri), :callable => block}
    end
  end

  def not_found(&block)
    @not_found = block
  end


  def initialize()
    @handlers = {}
  end

  def recieve(method, uri)
    http_method = method.downcase

    if @handlers[http_method]
      @handlers[http_method].each do |handler|
        params = handler[:uri].extract_params uri
        return handler[:callable].call params if handler[:uri].match? uri
      end
    end
    @not_found.call
  end
end
