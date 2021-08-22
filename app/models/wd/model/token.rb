module Wd
  module Model::Token
    extend ActiveSupport::Concern

    included do
      attribute :business, :string
      attribute :auth_token, :string

      belongs_to :user, optional: true
    end

  end
end
