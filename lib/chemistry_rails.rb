module ChemistryRails

end

module ChemistryRails
  class Railtie < Rails::Railtie

    initializer "chemistry_rails.active_record" do
      ActiveSupport.on_load :active_record do
        require 'chemistry_rails/orm/activerecord'
      end
    end

    ##
    # Loads the Carrierwave locale files before the Rails application locales
    # letting the Rails application overrite the carrierwave locale defaults
    config.before_configuration do
      I18n.load_path << File.join(File.dirname(__FILE__), "carrierwave", "locale", 'en.yml')
    end
  end
end