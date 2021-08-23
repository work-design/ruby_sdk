module Wd
  module Ext::User
    extend ActiveSupport::Concern

    included do
      has_many :wd_tokens, class_name: 'Wd::Token'
    end

  end
end
