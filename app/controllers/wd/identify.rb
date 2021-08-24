module Wd
  module Identify
    extend ActiveSupport::Concern

    included do
    end

    def current_user
    end

    def auth_token
      return @auth_token if defined? @auth_token
      @auth_token = request.headers['Authorization'].to_s.split(' ').last.presence
    end

    def decode_auth_token
      begin
        payload, _ = JWT.decode(auth_token, nil, false, verify_expiration: false)
        return unless payload
        key = 'abcdefghijklmn'  #fixme 在 auth 后台配置

        payload, _ = JWT.decode(auth_token, key, true, 'sub' => payload['sub'], verify_sub: true, verify_expiration: false)
        payload['sub'].constantize.find payload['iss']
      rescue => e
        logger.debug e.full_message(highlight: true, order: :top)
      end
    end

  end
end
