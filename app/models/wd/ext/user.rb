module Wd
  module Model::User
    extend ActiveSupport::Concern

    included do
      has_many :tokens, class_name: 'Wd::Token'
    end

  end
end
