# frozen_string_literal: true

module Dnd5NewCharacter
  module Races
    class ElfDecorator
      DEFAULT_SELECTED_SKILLS = %w[perception].freeze
      LANGUAGES = %w[common elvish].freeze

      def decorate(result:)
        result[:speed] = 30
        result[:languages] = result[:languages].concat(LANGUAGES)
        result[:selected_skills] = result[:selected_skills].concat(DEFAULT_SELECTED_SKILLS)

        result
      end
    end
  end
end
