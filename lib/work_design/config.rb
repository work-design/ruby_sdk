module WorkDesign
  include ActiveSupport::Configurable

  configure do |config|
    config.services = ActiveSupport::OrderedOptions.new
    config.services.wechat = {
      scheme: 'https',
      host: 'wechat.work.design',
      port: 443
    }
  end

end
