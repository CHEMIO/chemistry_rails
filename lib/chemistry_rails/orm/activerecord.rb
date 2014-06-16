# encoding: utf-8

require 'active_record'

module ChemistryRails
  module ActiveRecord

    def chemical_formula(column)

      validates_format_of column, with: /([a-zA-Z]+[0-9]*)+/i, message: :chemistry_rails_formula

    end

  end # ActiveRecord
end # CarrierWave

ActiveRecord::Base.extend ChemistryRails::ActiveRecord