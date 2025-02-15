# frozen_string_literal: true

module Dnd5Character
  module Races
    class HalfElfDecorator
      LANGUAGES = %w[common elvish].freeze

      def decorate_fresh_character(result:)
        result[:speed] = 30
        result[:languages] = result[:languages].concat(LANGUAGES).uniq

        result
      end

      def decorate_character_abilities(result:)
        result[:darkvision] = 60

        result
      end
    end
  end
end
