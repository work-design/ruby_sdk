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

      if defined?(current_user) && current_user && current_user.respond_to?(:wd_tokens)
        token = current_user.wd_tokens.find_or_initialize_by(business: params[:business])
      else
        token = Token.new(business: params[:business])
      end
      token.auth_token = r.headers['auth-token']
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
      hd = {}
      if request.format.symbol.nil?
        hd.merge! accept: 'application/json'
      else
        hd.merge! accept: request.format.to_s
      end

      if params[:auth_token]
        hd.merge! auth_token: params[:auth_token]
      elsif defined?(current_user) && current_user && current_user.respond_to?(:wd_tokens)
        auth_token = current_user.wd_tokens.find_by(business: params[:business])
        hd.merge! auth_token: auth_token if auth_token
      end

      hd
    end

  end
end
