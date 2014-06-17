# encoding: utf-8

require 'active_record'

module ChemistryRails
  module ActiveRecord

    def chemical_formula(column)

      validates_format_of column, with: /\A((#{ChemistryRails::ELEMENTS.reject(&:nil?).map{|i| i[:short] }.join('|')})+[0-9]*)+\Z/, message: :chemistry_rails_formula

      class_eval <<-RUBY, __FILE__, __LINE__+1
        def #{column}
          ChemistryRails::Formula.new(self.read_attribute(:#{column}))
        end
      RUBY

    end

  end # ActiveRecord
end # CarrierWave

ActiveRecord::Base.extend ChemistryRails::ActiveRecord