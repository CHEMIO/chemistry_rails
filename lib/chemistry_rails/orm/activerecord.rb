# encoding: utf-8

require 'active_record'

module ChemistryRails
  module ActiveRecord

    def chemical_formula(column)

      validates_format_of column, with: /\A((#{ChemistryRails::ELEMENTS.map{|i| i[:short] }.join('|')})+[0-9]*)+\Z/, message: :chemistry_rails_formula

    end

  end # ActiveRecord
end # CarrierWave

ActiveRecord::Base.extend ChemistryRails::ActiveRecord