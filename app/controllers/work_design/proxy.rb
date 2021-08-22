require 'httpx'
module WorkDesign
  module Proxy

    def proxy_request
      process_request
      yield
      process_body
    end

    def process_request
      url = URI(request.url)
      url.host = 'lvh.me'
      url.port = 3001

      r = HTTPX.request(
        request.method,
        url,
        headers: process_headers,
        json: request.request_parameters
      )

      case request.format.symbol
      when :json, nil
        @body = JSON.parse(r.body.read)
      end
    end

    def process_body
      if response.no_content?
        response.status = 200
        response.body = @body.to_json
      else
        response.body = @body.merge!(a: 1).to_json if @body
      end
    end

    def process_headers
      if request.format.symbol.nil?
        { accept: 'application/json' }
      else
        { accept: request.format.to_s }
      end
    end

  end
end
