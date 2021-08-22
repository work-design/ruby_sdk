require 'httpx'
module Wd
  module Proxy

    def proxy_request
      process_request
      yield
      process_response
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

      token = Token.new(business: params[:business], auth_token: r.headers['auth-token'])
      token.save

      case request.format.symbol
      when :json, nil
        @body = JSON.parse(r.body.read)
      end
    end

    def process_response
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
