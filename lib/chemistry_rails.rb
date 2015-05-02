module ChemistryRails
  ELEMENT_CATEGORIES = ['Alkali Metal', 'Alkaline Earth', 'Transition Metal', 'Basic Metal', 'Semimetal', 'Nonmetal', 'Halogen', 'Noble gas', 'Lanthanide', 'Actinide']

  ELEMENTS = [
      nil,
      { short: 'H',  long: 'Hydrogen',     mass: 1.0079,    category: 5 },
      { short: 'He', long: 'Helium',       mass: 4.00260,   category: 7 },
      { short: 'Li', long: 'Lithium',      mass: 6.941,     category: 0 },
      { short: 'Be', long: 'Beryllium',    mass: 9.01218,   category: 1 },
      { short: 'B',  long: 'Boron',        mass: 10.811,    category: 4 },
      { short: 'C',  long: 'Carbon',       mass: 12.011,    category: 5 },
      { short: 'N',  long: 'Nitrogen',     mass: 14.00674,  category: 5 },
      { short: 'O',  long: 'Oxygen',       mass: 15.9994,   category: 5 },
      { short: 'F',  long: 'Fluorine',     mass: 18.998403, category: 6 },
      { short: 'Ne', long: 'Neon',         mass: 20.1797,   category: 7 },    #10
      { short: 'Na', long: 'Sodium',       mass: 22.989768, category: 0 },
      { short: 'Mg', long: 'Magnesium',    mass: 24.305,    category: 1 },
      { short: 'Al', long: 'Aluminium',    mass: 26.981539, category: 3 },
      { short: 'Si', long: 'Silicon',      mass: 28.0855,   category: 4 },
      { short: 'P',  long: 'Phosphorus',   mass: 30.973762, category: 5 },
      { short: 'S',  long: 'Sulfur',       mass: 32.066,    category: 5 },
      { short: 'Cl', long: 'Chlorine',     mass: 35.4527,   category: 6 },
      { short: 'Ar', long: 'Argon',        mass: 39.948,    category: 7 },
      { short: 'K',  long: 'Potassium',    mass: 39.0983,   category: 0 },
      { short: 'Ca', long: 'Calcium',      mass: 40.078,    category: 1 },    #20
      { short: 'Sc', long: 'Scandium',     mass: 44.95591,  category: 2 },
      { short: 'Ti', long: 'Titanium',     mass: 47.88,     category: 2 },
      { short: 'V',  long: 'Venadium',     mass: 50.9415,   category: 2 },
      { short: 'Cr', long: 'Chromium',     mass: 51.9961,   category: 2 },
      { short: 'Mn', long: 'Manganese',    mass: 54.938,    category: 2 },
      { short: 'Fe', long: 'Iron',         mass: 54.847,    category: 2 },
      { short: 'Co', long: 'Cobalt',       mass: 58.9332,   category: 2 },
      { short: 'Ni', long: 'Nickel',       mass: 58.6934,   category: 2 },
      { short: 'Cu', long: 'Copper',       mass: 63.546,    category: 2 },
      { short: 'Zn', long: 'Zinc',         mass: 65.39,     category: 2 },    #30
      { short: 'Ga', long: 'Gallium',      mass: 69.732,    category: 3 },
      { short: 'Ge', long: 'Germanium',    mass: 72.64,     category: 4 },
      { short: 'As', long: 'Arsenic',      mass: 74.92159,  category: 4 },
      { short: 'Se', long: 'Selenium',     mass: 78.96,     category: 5 },
      { short: 'Br', long: 'Bromine',      mass: 79.904,    category: 6 },
      { short: 'Kr', long: 'Krypton',      mass: 83.80,     category: 7 },
      { short: 'Rb', long: 'Rubidium',     mass: 85.4678,   category: 0 },
      { short: 'Sr', long: 'Strontium',    mass: 87.62,     category: 1 },
      { short: 'Y',  long: 'Yttrium',      mass: 88.90585,  category: 2 },
      { short: 'Zr', long: 'Zirconium',    mass: 91.224,    category: 2 },    #40
      { short: 'Nb', long: 'Niobium',      mass: 92.90638,  category: 2 },
      { short: 'Mo', long: 'Molybdenum',   mass: 95.94,     category: 2 },
      { short: 'Tc', long: 'Technetium',   mass: 98.9072,   category: 2 },
      { short: 'Ru', long: 'Ruthenium',    mass: 101.07,    category: 2 },
      { short: 'Rh', long: 'Rhodium',      mass: 102.9055,  category: 2 },
      { short: 'Pd', long: 'Palladium',    mass: 106.42,    category: 2 },
      { short: 'Ag', long: 'Silver',       mass: 107.8682,  category: 2 },
      { short: 'Cd', long: 'Cadmium',      mass: 112.411,   category: 2 },
      { short: 'In', long: 'Indium',       mass: 114.818,   category: 3 },
      { short: 'Sn', long: 'Tin',          mass: 118.71,    category: 3 },    #50
      { short: 'Sb', long: 'Antimony',     mass: 121.760,   category: 4 },
      { short: 'Te', long: 'Tellurium',    mass: 127.6,     category: 4 },
      { short: 'I',  long: 'Iodine',       mass: 126.90447, category: 6 },
      { short: 'Xe', long: 'Xenon',        mass: 131.29,    category: 7 },
      { short: 'Cs', long: 'Cesium',       mass: 132.90543, category: 0 },
      { short: 'Ba', long: 'Barium',       mass: 137.327,   category: 1 },

      { short: 'La', long: 'Lanthanum',    mass: 138.9055,  category:  8 },
      { short: 'Ce', long: 'Cerium',       mass: 140.115,   category:  8 },
      { short: 'Pr', long: 'Praseodymium', mass: 140.90765, category:  8 },
      { short: 'Nd', long: 'Neodymium',    mass: 144.24,    category:  8 },   #60
      { short: 'Pm', long: 'Promethium',   mass: 144.9127,  category:  8 },
      { short: 'Sm', long: 'Samarium',     mass: 150.36,    category:  8 },
      { short: 'Eu', long: 'Europium',     mass: 151.9655,  category:  8 },
      { short: 'Gd', long: 'Gadolinium',   mass: 157.25,    category:  8 },
      { short: 'Tb', long: 'Terbium',      mass: 158.92534, category:  8 },
      { short: 'Dy', long: 'Dysprosium',   mass: 162.50,    category:  8 },
      { short: 'Ho', long: 'Holmium',      mass: 164.93032, category:  8 },
      { short: 'Er', long: 'Erbium',       mass: 167.26,    category:  8 },
      { short: 'Tm', long: 'Thulium',      mass: 168.93421, category:  8 },
      { short: 'Yb', long: 'Ytterbium',    mass: 173.04,    category:  8 },   #70
      { short: 'Lu', long: 'Lutetium',     mass: 174.967,   category:  8 },

      { short: 'Hf', long: 'Hafnium',      mass: 178.49,    category:  2 },
      { short: 'Ta', long: 'Tantalum',     mass: 180.9479,  category:  2 },
      { short: 'W',  long: 'Tungsten',     mass: 183.85,    category:  2 },
      { short: 'Re', long: 'Rhenium',      mass: 186.207,   category:  2 },
      { short: 'Os', long: 'Osmium',       mass: 190.23,    category:  2 },
      { short: 'Ir', long: 'Iridium',      mass: 192.22,    category:  2 },
      { short: 'Pt', long: 'Platinum',     mass: 195.08,    category:  2 },
      { short: 'Au', long: 'Gold',         mass: 196.9665,  category:  2 },
      { short: 'Hg', long: 'Mercury',      mass: 200.59,    category:  2 },   #80
      { short: 'Tl', long: 'Thallium',     mass: 204.3833,  category:  3 },
      { short: 'Pb', long: 'Lead',         mass: 204.3833,  category:  3 },
      { short: 'Bi', long: 'Bismuth',      mass: 208.98037, category:  3 },
      { short: 'Po', long: 'Polonium',     mass: 208.9824,  category:  4 },
      { short: 'At', long: 'Astatine',     mass: 209.9871,  category:  6 },
      { short: 'Rn', long: 'Radon',        mass: 222.0176,  category:  7 },
      { short: 'Fr', long: 'Francium',     mass: 223.0197,  category:  0 },
      { short: 'Ra', long: 'Radium',       mass: 226.0254,  category:  1 },

      { short: 'Ac', long: 'Actinium',     mass: 227.0278,  category:  9 },
      { short: 'Th', long: 'Thorium',      mass: 232.0381,  category:  9 },   #90
      { short: 'Pa', long: 'Protactinium', mass: 231.03588, category:  9 },
      { short: 'U',  long: 'Uranium',      mass: 238.0289,  category:  9 },
      { short: 'Np', long: 'Neptunium',    mass: 237.0482,  category:  9 },
      { short: 'Pu', long: 'Plutonium',    mass: 244.0642,  category:  9 },
      { short: 'Am', long: 'Americium',    mass: 243.0614,  category:  9 },
      { short: 'Cm', long: 'Curium',       mass: 247.0703,  category:  9 },
      { short: 'Bk', long: 'Berkelium',    mass: 247.0703,  category:  9 },
      { short: 'Cf', long: 'Californium',  mass: 251.0796,  category:  9 },
      { short: 'Es', long: 'Einsteinium',  mass: 254,       category:  9 },
      { short: 'Fm', long: 'Fermium',      mass: 257.0951,  category:  9 },   #100
      { short: 'Md', long: 'Mendelevium',  mass: 258.1,     category:  9 },
      { short: 'No', long: 'Nobelium',     mass: 259.1009,  category:  9 },
      { short: 'Lr', long: 'Lawrencium',   mass: 262,       category:  9 },

      { short: 'Rf', long: 'Rutherfordium',mass: 261,       category:  2 },
      { short: 'Db', long: 'Dubnium',      mass: 262,       category:  2 },
      { short: 'Sg', long: 'Seaborgium',   mass: 266,       category:  2 },
      { short: 'Bh', long: 'Bohrium',      mass: 264,       category:  2 },
      { short: 'Hs', long: 'Hassium',      mass: 269,       category:  2 },
      { short: 'Mt', long: 'Meitnerium',   mass: 268,       category:  2 },
      { short: 'Ds', long: 'Darmstadium',  mass: 269,       category:  2 },   #110
      { short: 'Rg', long: 'Roentgenium',  mass: 272,       category:  2 },
      { short: 'Cn', long: 'Copernicium',  mass: 277,       category:  2 },
      { short: 'Uut',long: 'Ununtrium',    mass: 286,       category:  3 },
      { short: 'Fl', long: 'Flerovium',    mass: 289,       category:  3 },
      { short: 'Uup',long: 'Ununpentium',  mass: 288,       category:  3 },
      { short: 'Lv', long: 'Livermorium',  mass: 293,       category:  3 },
      { short: 'Uus',long: 'Ununseptium',  mass: 294,       category:  6 },
      { short: 'Uuo',long: 'Ununoctium',   mass: 294,       category:  7 },   #118
  ]

  class << self

    def elements(category = nil)
      category ? ELEMENTS.select {|e| e && e[:category] == category} : ELEMENTS
    end

    def element(short)
      ELEMENTS.select{|e| e && e[:short] == short}.first
    end

    def alkali_metals;    elements(0); end
    def alkaline_earth;   elements(1); end
    def transition_metals;elements(2); end
    def basic_metals;     elements(3); end
    def semi_metals;      elements(4); end
    def non_metals;       elements(5); end
    def halogens;         elements(6); end
    def noble_gases;      elements(7); end
    def lanthanides;      elements(8); end
    def actinides;        elements(9); end

  end

end

module ChemistryRails
  class Railtie < Rails::Railtie

    initializer "chemistry_rails.active_record" do
      ActiveSupport.on_load :active_record do
        require 'chemistry_rails/orm/activerecord'
      end
    end

    ##
    # Loads the locale files before the Rails application locales
    # letting the Rails application override the locale defaults
    config.before_configuration do
      I18n.load_path << File.join(File.dirname(__FILE__), "chemistry_rails", "locale", 'en.yml')
    end
  end
end

module ChemistryRails
  class Formula

    attr_accessor :formula, :elements

    def initialize(formula, options={})
      @formula = formula
      @options = options
      @elements = Hash[formula.scan(/([A-Z][a-z]{0,2})(\d*)/).map{|k,v| [k, v.blank? ? 1 : v.to_i]}]
    end

    def to_s; formula; end
    def empty?; formula.blank?; end

    def to_html
      elements.map { |el, i|  "#{el}<sub>#{i > 1 ? i : ''}</sub>" }.join('')
    end

    def elemental_analysis(include_oxygen = false)
      return {} unless valid_elements?
      mass = elements.map { |el, i|  ChemistryRails.element(el)[:mass] * i }.inject{|sum,x| sum + x }

      Hash[
          elements.select {|k, _| ['C', 'H', 'N', 'S', 'P'].include? k }.map { |el, i|
            [ el, (ChemistryRails.element(el)[:mass] * i / mass * 100).round(2) ]
          }
      ]
    end

    def valid_elements?
      elements.all? { |k, _| ChemistryRails.element(k) }
    end
  end
end