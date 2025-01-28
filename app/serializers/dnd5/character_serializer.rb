# frozen_string_literal: true

module Dnd5
  class CharacterSerializer < ApplicationSerializer
    attributes :id, :name, :object_data, :decorated_data, :provider

    delegate :decorator, to: :object

    def object_data
      object.data.slice('level', 'race', 'subrace', 'classes')
    end

    def decorated_data
      decorator.decorate
    end

    def provider
      'dnd5'
    end
  end
end
