module WorkDesign
  include ActiveSupport::Configurable

  configure do |config|
    config.scheme = 'http'
    config.host = '0.0.0.0'
    config.port = '3000'
  end

end
