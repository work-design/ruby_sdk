module Wd
  module Model::Token
    extend ActiveSupport::Concern

    included do
      attribute :business, :string
      attribute :auth_token, :string
      attribute :expire_at, :datetime

      belongs_to :user, optional: true
    end

  end
end
