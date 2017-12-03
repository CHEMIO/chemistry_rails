require 'cas_number_validator'
module ChemistryRails
  ELEMENT_CATEGORIES = ['Alkali Metal', 'Alkaline Earth', 'Transition Metal', 'Basic Metal', 'Semimetal', 'Nonmetal', 'Halogen', 'Noble gas', 'Lanthanide', 'Actinide'].freeze

  ELEMENTS = [
      nil,
      { short: 'H', long: 'Hydrogen', mass: 1.0079, category: 5,
        radionuclides: [
            { name: 'H-3', exemption_level: 10**9, t_medium: 100 }
        ]
      },
      { short: 'He', long: 'Helium',       mass: 4.00260,   category: 7,
        radionuclides: [
            { name: 'H-3', exemption_level: 10**9, t_medium: 100 }
        ]
      },
      { short: 'Li', long: 'Lithium',      mass: 6.941,     category: 0,
        radionuclides: [
            { name: 'H-3', exemption_level: 10**9, t_medium: 100 }
        ]
      },
      { short: 'Be', long: 'Beryllium',    mass: 9.01218,   category: 1,
        radionuclides: [
            { name: 'Be-7', exemption_level: 10**7, t_medium: 100 },
            { name: 'Be-10', exemption_level: 10**6, t_medium: 100 }
        ]
      },
      { short: 'B',  long: 'Boron',        mass: 10.811,    category: 4,
        radionuclides: [
            { name: 'H-3', exemption_level: 10**9, t_medium: 100 }
        ]
      },
      { short: 'C',  long: 'Carbon',       mass: 12.011,    category: 5,
        radionuclides: [
            { name: 'C-11', exemption_level: 10**6, t_medium: 100 },
            { name: 'C-14', exemption_level: 10**7, t_medium: 100 }
        ]
      },
      { short: 'N',  long: 'Nitrogen',     mass: 14.00674,  category: 5,
        radionuclides: [
            { name: 'N-13', exemption_level: 10**9, t_medium: 100 },
        ]
      },
      { short: 'O',  long: 'Oxygen',       mass: 15.9994,   category: 5,
        radionuclides: [
            { name: 'O-15', exemption_level: 10**9, t_medium: 100 },
        ]
      },
      { short: 'F',  long: 'Fluorine',     mass: 18.998403, category: 6,
        radionuclides: [
            { name: 'F-18', exemption_level: 10**9, t_medium: 100 }
        ]
      },
      { short: 'Ne', long: 'Neon',         mass: 20.1797,   category: 7,
        radionuclides: [
            { name: 'N-19', exemption_level: 10**9, t_medium: 100 },
        ]
      },    # 10
      { short: 'Na', long: 'Sodium',       mass: 22.989768, category: 0,
        radionuclides: [
            { name: 'Na-22', exemption_level: 10**9, t_medium: 100 },
            { name: 'Na-24', exemption_level: 10**9, t_medium: 100 }
        ]
      },
      { short: 'Mg', long: 'Magnesium',    mass: 24.305,    category: 1,
        radionuclides: [
            { name: 'Mg-28', exemption_level: 10**9, t_medium: 100 }
        ]
      },
      { short: 'Al', long: 'Aluminium',    mass: 26.981539, category: 3,
        radionuclides: [
            { name: 'Al-26', exemption_level: 10**9, t_medium: 100 }
        ]
      },
      { short: 'Si', long: 'Silicon',      mass: 28.0855,   category: 4,
        radionuclides: [
            { name: 'Si-31', exemption_level: 10**9, t_medium: 100 },
            { name: 'Si-32', exemption_level: 10**9, t_medium: 100 }
        ]
      },
      { short: 'P',  long: 'Phosphorus',   mass: 30.973762, category: 5,
        radionuclides: [
            { name: 'P-32', exemption_level: 10**9, t_medium: 100 },
            { name: 'P-33', exemption_level: 10**9, t_medium: 100 }
        ]
      },
      { short: 'S',  long: 'Sulfur',       mass: 32.066,    category: 5,
        radionuclides: [
            { name: 'S-35', exemption_level: 10**9, t_medium: 100 }
        ]
      },
      { short: 'Cl', long: 'Chlorine',     mass: 35.4527,   category: 6,
        radionuclides: [
            { name: 'Cl-36', exemption_level: 10**9, t_medium: 100 },
            { name: 'Cl-38', exemption_level: 10**9, t_medium: 100 },
            { name: 'Cl-39', exemption_level: 10**9, t_medium: 100 }
        ]
      },
      { short: 'Ar', long: 'Argon',        mass: 39.948,    category: 7,
        radionuclides: [
            { name: 'Ar-37', exemption_level: 10**9, t_medium: 100 },
            { name: 'Ar-39', exemption_level: 10**9, t_medium: 100 },
            { name: 'Ar-41', exemption_level: 10**9, t_medium: 100 }
        ]
      },
      { short: 'K',  long: 'Potassium',    mass: 39.0983,   category: 0,
        radionuclides: [
            { name: 'K-40', exemption_level: 10**9, t_medium: 100 },
            { name: 'K-42', exemption_level: 10**9, t_medium: 100 },
            { name: 'K-43', exemption_level: 10**9, t_medium: 100 },
            { name: 'K-44', exemption_level: 10**9, t_medium: 100 },
            { name: 'K-45', exemption_level: 10**9, t_medium: 100 },
        ]
      },
      { short: 'Ca', long: 'Calcium',      mass: 40.078,    category: 1,
        radionuclides: [
            { name: 'Ca-41', exemption_level: 10**9, t_medium: 100 },
            { name: 'Ca-45', exemption_level: 10**9, t_medium: 100 },
            { name: 'Ca-47', exemption_level: 10**9, t_medium: 100 },
        ]
      },    # 20
      { short: 'Sc', long: 'Scandium',     mass: 44.95591,  category: 2,
        radionuclides: [
            { name: 'Sc-43', exemption_level: 10**9, t_medium: 100 },
            { name: 'Sc-44', exemption_level: 10**9, t_medium: 100 },
            { name: 'Sc-45', exemption_level: 10**9, t_medium: 100 },
            { name: 'Sc-46', exemption_level: 10**9, t_medium: 100 },
            { name: 'Sc-47', exemption_level: 10**9, t_medium: 100 },
            { name: 'Sc-48', exemption_level: 10**9, t_medium: 100 },
            { name: 'Sc-49', exemption_level: 10**9, t_medium: 100 },
        ]
      },
      { short: 'Ti', long: 'Titanium',     mass: 47.88,     category: 2,
        radionuclides: [
            { name: 'Ti-44', exemption_level: 10**9, t_medium: 100 },
            { name: 'Ti-45', exemption_level: 10**9, t_medium: 100 },
        ]
      },
      { short: 'V',  long: 'Vanadium',     mass: 50.9415,   category: 2,
        radionuclides: [
            { name: 'V-47', exemption_level: 10**9, t_medium: 100 },
            { name: 'V-48', exemption_level: 10**9, t_medium: 100 },
            { name: 'V-49', exemption_level: 10**9, t_medium: 100 },
        ]
      },
      { short: 'Cr', long: 'Chromium',     mass: 51.9961,   category: 2,
        radionuclides: [
            { name: 'Cr-48', exemption_level: 10**9, t_medium: 100 },
            { name: 'Cr-49', exemption_level: 10**9, t_medium: 100 },
            { name: 'Cr-51', exemption_level: 10**9, t_medium: 100 },
        ]
      },
      { short: 'Mn', long: 'Manganese',    mass: 54.938,    category: 2,
        radionuclides: [
            { name: 'Mn-51', exemption_level: 10**9, t_medium: 100 },
            { name: 'Mn-52', exemption_level: 10**9, t_medium: 100 },
            { name: 'Mn-52m', exemption_level: 10**9, t_medium: 100 },
            { name: 'Mn-53', exemption_level: 10**9, t_medium: 100 },
            { name: 'Mn-54', exemption_level: 10**9, t_medium: 100 },
            { name: 'Mn-56', exemption_level: 10**9, t_medium: 100 },
        ]
      },
      { short: 'Fe', long: 'Iron',         mass: 54.847,    category: 2,
        radionuclides: [
            { name: 'Fe-52', exemption_level: 10**9, t_medium: 100 },
            { name: 'Fe-55', exemption_level: 10**9, t_medium: 100 },
            { name: 'Fe-59', exemption_level: 10**9, t_medium: 100 },
            { name: 'Fe-60', exemption_level: 10**9, t_medium: 100 },
        ]
      },
      { short: 'Co', long: 'Cobalt',       mass: 58.9332,   category: 2,
        radionuclides: [
            { name: 'Co-55', exemption_level: 10**9, t_medium: 100 },
            { name: 'Co-56', exemption_level: 10**9, t_medium: 100 },
            { name: 'Co-57', exemption_level: 10**9, t_medium: 100 },
            { name: 'Co-58', exemption_level: 10**9, t_medium: 100 },
            { name: 'Co-58m', exemption_level: 10**9, t_medium: 100 },
            { name: 'Co-60', exemption_level: 10**9, t_medium: 100 },
            { name: 'Co-60m', exemption_level: 10**9, t_medium: 100 },
            { name: 'Co-61', exemption_level: 10**9, t_medium: 100 },
            { name: 'Co-62m', exemption_level: 10**9, t_medium: 100 },
        ]
      },
      { short: 'Ni', long: 'Nickel',       mass: 58.6934,   category: 2,
        radionuclides: [
            { name: 'Ni-56', exemption_level: 10**9, t_medium: 100 },
            { name: 'Ni-57', exemption_level: 10**9, t_medium: 100 },
            { name: 'Ni-59', exemption_level: 10**9, t_medium: 100 },
            { name: 'Ni-63', exemption_level: 10**9, t_medium: 100 },
            { name: 'Ni-65', exemption_level: 10**9, t_medium: 100 },
            { name: 'Ni-66', exemption_level: 10**9, t_medium: 100 },
        ]
      },
      { short: 'Cu', long: 'Copper',       mass: 63.546,    category: 2,
        radionuclides: [
            { name: 'Cu-60', exemption_level: 10**9, t_medium: 100 },
            { name: 'Cu-61', exemption_level: 10**9, t_medium: 100 },
            { name: 'Cu-64', exemption_level: 10**9, t_medium: 100 },
            { name: 'Cu-67', exemption_level: 10**9, t_medium: 100 },
        ]
      },
      { short: 'Zn', long: 'Zinc',         mass: 65.39,     category: 2,
        radionuclides: [
            { name: 'Zn-62', exemption_level: 10**9, t_medium: 100 },
            { name: 'Zn-63', exemption_level: 10**9, t_medium: 100 },
            { name: 'Zn-65', exemption_level: 10**9, t_medium: 100 },
            { name: 'Zn-69', exemption_level: 10**9, t_medium: 100 },
            { name: 'Zn-69m', exemption_level: 10**9, t_medium: 100 },
            { name: 'Zn-71m', exemption_level: 10**9, t_medium: 100 },
            { name: 'Zn-72', exemption_level: 10**9, t_medium: 100 },
        ]
      },    # 30
      { short: 'Ga', long: 'Gallium',      mass: 69.732,    category: 3,
        radionuclides: [
            { name: 'Ga-65', exemption_level: 10**9, t_medium: 100 },
            { name: 'Ga-66', exemption_level: 10**9, t_medium: 100 },
            { name: 'Ga-67', exemption_level: 10**9, t_medium: 100 },
            { name: 'Ga-68', exemption_level: 10**9, t_medium: 100 },
            { name: 'Ga-70', exemption_level: 10**9, t_medium: 100 },
            { name: 'Ga-72', exemption_level: 10**9, t_medium: 100 },
            { name: 'Ga-73', exemption_level: 10**9, t_medium: 100 },
        ]
      },
      { short: 'Ge', long: 'Germanium',    mass: 72.64,     category: 4,
        radionuclides: [
            { name: 'Ge-66', exemption_level: 10**9, t_medium: 100 },
            { name: 'Ge-67', exemption_level: 10**9, t_medium: 100 },
            { name: 'Ge-68', exemption_level: 10**9, t_medium: 100 },
            { name: 'Ge-69', exemption_level: 10**9, t_medium: 100 },
            { name: 'Ge-71', exemption_level: 10**9, t_medium: 100 },
            { name: 'Ge-75', exemption_level: 10**9, t_medium: 100 },
            { name: 'Ge-77', exemption_level: 10**9, t_medium: 100 },
            { name: 'Ge-78', exemption_level: 10**9, t_medium: 100 },
        ]
      },
      { short: 'As', long: 'Arsenic',      mass: 74.92159,  category: 4,
        radionuclides: [
            { name: 'As-69', exemption_level: 10**9, t_medium: 100 },
            { name: 'As-70', exemption_level: 10**9, t_medium: 100 },
            { name: 'As-71', exemption_level: 10**9, t_medium: 100 },
            { name: 'As-72', exemption_level: 10**9, t_medium: 100 },
            { name: 'As-73', exemption_level: 10**9, t_medium: 100 },
            { name: 'As-74', exemption_level: 10**9, t_medium: 100 },
            { name: 'As-76', exemption_level: 10**9, t_medium: 100 },
            { name: 'As-77', exemption_level: 10**9, t_medium: 100 },
            { name: 'As-78', exemption_level: 10**9, t_medium: 100 },
        ]
      },
      { short: 'Se', long: 'Selenium',     mass: 78.96,     category: 5,
        radionuclides: [
            { name: 'Se-70', exemption_level: 10**9, t_medium: 100 },
            { name: 'Se-73', exemption_level: 10**9, t_medium: 100 },
            { name: 'Se-73m', exemption_level: 10**9, t_medium: 100 },
            { name: 'Se-75', exemption_level: 10**9, t_medium: 100 },
            { name: 'Se-79', exemption_level: 10**9, t_medium: 100 },
            { name: 'Se-81', exemption_level: 10**9, t_medium: 100 },
            { name: 'Se-81m', exemption_level: 10**9, t_medium: 100 },
            { name: 'Se-83', exemption_level: 10**9, t_medium: 100 },
        ]
      },
      { short: 'Br', long: 'Bromine',      mass: 79.904,    category: 6,
        radionuclides: [
            { name: 'Br-74', exemption_level: 10**9, t_medium: 100 },
            { name: 'Br-74m', exemption_level: 10**9, t_medium: 100 },
            { name: 'Br-75', exemption_level: 10**9, t_medium: 100 },
            { name: 'Br-76', exemption_level: 10**9, t_medium: 100 },
            { name: 'Br-77', exemption_level: 10**9, t_medium: 100 },
            { name: 'Br-80', exemption_level: 10**9, t_medium: 100 },
            { name: 'Br-80m', exemption_level: 10**9, t_medium: 100 },
            { name: 'Br-82', exemption_level: 10**9, t_medium: 100 },
            { name: 'Br-83', exemption_level: 10**9, t_medium: 100 },
            { name: 'Br-84', exemption_level: 10**9, t_medium: 100 },
        ]
      },
      { short: 'Kr', long: 'Krypton',      mass: 83.80,     category: 7,
        radionuclides: [
            { name: 'Kr-74', exemption_level: 10**9, t_medium: 100 },
            { name: 'Kr-76', exemption_level: 10**9, t_medium: 100 },
            { name: 'Kr-77', exemption_level: 10**9, t_medium: 100 },
            { name: 'Kr-79', exemption_level: 10**9, t_medium: 100 },
            { name: 'Kr-81', exemption_level: 10**9, t_medium: 100 },
            { name: 'Kr-81m', exemption_level: 10**9, t_medium: 100 },
            { name: 'Kr-83m', exemption_level: 10**9, t_medium: 100 },
            { name: 'Kr-85', exemption_level: 10**9, t_medium: 100 },
            { name: 'Kr-85m', exemption_level: 10**9, t_medium: 100 },
            { name: 'Kr-87', exemption_level: 10**9, t_medium: 100 },
            { name: 'Kr-88', exemption_level: 10**9, t_medium: 100 },
        ]
      },
      { short: 'Rb', long: 'Rubidium',     mass: 85.4678,   category: 0,
        radionuclides: [
            { name: 'Rb-79', exemption_level: 10**9, t_medium: 100 },
            { name: 'Rb-81', exemption_level: 10**9, t_medium: 100 },
            { name: 'Rb-81m', exemption_level: 10**9, t_medium: 100 },
            { name: 'Rb-82m', exemption_level: 10**9, t_medium: 100 },
            { name: 'Rb-83', exemption_level: 10**9, t_medium: 100 },
            { name: 'Rb-84', exemption_level: 10**9, t_medium: 100 },
            { name: 'Rb-86', exemption_level: 10**9, t_medium: 100 },
            { name: 'Rb-87', exemption_level: 10**9, t_medium: 100 },
            { name: 'Rb-88', exemption_level: 10**9, t_medium: 100 },
            { name: 'Rb-89', exemption_level: 10**9, t_medium: 100 },
        ]
      },
      { short: 'Sr', long: 'Strontium',    mass: 87.62,     category: 1,
        radionuclides: [
            { name: 'Sr-80', exemption_level: 10**9, t_medium: 100 },
            { name: 'Sr-81', exemption_level: 10**9, t_medium: 100 },
            { name: 'Sr-82', exemption_level: 10**9, t_medium: 100 },
            { name: 'Sr-83', exemption_level: 10**9, t_medium: 100 },
            { name: 'Sr-85', exemption_level: 10**9, t_medium: 100 },
            { name: 'Sr-85m', exemption_level: 10**9, t_medium: 100 },
            { name: 'Sr-87m', exemption_level: 10**9, t_medium: 100 },
            { name: 'Sr-89', exemption_level: 10**9, t_medium: 100 },
            { name: 'Sr-90', exemption_level: 10**9, t_medium: 100 },
            { name: 'Sr-91', exemption_level: 10**9, t_medium: 100 },
            { name: 'Sr-92', exemption_level: 10**9, t_medium: 100 },
        ]
      },
      { short: 'Y',  long: 'Yttrium',      mass: 88.90585,  category: 2,
        radionuclides: [
            { name: 'Y-86', exemption_level: 10**9, t_medium: 100 },
            { name: 'Y-86m', exemption_level: 10**9, t_medium: 100 },
            { name: 'Y-87', exemption_level: 10**9, t_medium: 100 },
            { name: 'Y-88', exemption_level: 10**9, t_medium: 100 },
            { name: 'Y-90', exemption_level: 10**9, t_medium: 100 },
            { name: 'Y-90m', exemption_level: 10**9, t_medium: 100 },
            { name: 'Y-91', exemption_level: 10**9, t_medium: 100 },
            { name: 'Y-91m', exemption_level: 10**9, t_medium: 100 },
            { name: 'Y-92', exemption_level: 10**9, t_medium: 100 },
            { name: 'Y-93', exemption_level: 10**9, t_medium: 100 },
            { name: 'Y-94', exemption_level: 10**9, t_medium: 100 },
            { name: 'Y-95', exemption_level: 10**9, t_medium: 100 },
        ]
      },
      { short: 'Zr', long: 'Zirconium',    mass: 91.224,    category: 2,
        radionuclides: [
            { name: 'Zr-86', exemption_level: 10**9, t_medium: 100 },
            { name: 'Zr-88', exemption_level: 10**9, t_medium: 100 },
            { name: 'Zr-89', exemption_level: 10**9, t_medium: 100 },
            { name: 'Zr-93', exemption_level: 10**9, t_medium: 100 },
            { name: 'Zr-95', exemption_level: 10**9, t_medium: 100 },
            { name: 'Zr-97', exemption_level: 10**9, t_medium: 100 },
        ]
      },    # 40
      { short: 'Nb', long: 'Niobium',      mass: 92.90638,  category: 2,
        radionuclides: [
            { name: 'Nb-88', exemption_level: 10**9, t_medium: 100 },
            { name: 'Nb-89', exemption_level: 10**9, t_medium: 100 },
            { name: 'Nb-89m', exemption_level: 10**9, t_medium: 100 },
            { name: 'Nb-90', exemption_level: 10**9, t_medium: 100 },
            { name: 'Nb-93m', exemption_level: 10**9, t_medium: 100 },
            { name: 'Nb-94', exemption_level: 10**9, t_medium: 100 },
            { name: 'Nb-95', exemption_level: 10**9, t_medium: 100 },
            { name: 'Nb-95m', exemption_level: 10**9, t_medium: 100 },
            { name: 'Nb-96', exemption_level: 10**9, t_medium: 100 },
            { name: 'Nb-97', exemption_level: 10**9, t_medium: 100 },
            { name: 'Nb-98', exemption_level: 10**9, t_medium: 100 },
        ]
      },
      { short: 'Mo', long: 'Molybdenum',   mass: 95.94,     category: 2,
        radionuclides: [
            { name: 'Mo-90', exemption_level: 10**9, t_medium: 100 },
            { name: 'Mo-93', exemption_level: 10**9, t_medium: 100 },
            { name: 'Mo-93m', exemption_level: 10**9, t_medium: 100 },
            { name: 'Mo-99', exemption_level: 10**9, t_medium: 100 },
            { name: 'Mo-101', exemption_level: 10**9, t_medium: 100 },
        ]
      },
      { short: 'Tc', long: 'Technetium',   mass: 98.9072,   category: 2,
        radionuclides: [
            { name: 'Tc-93', exemption_level: 10**9, t_medium: 100 },
            { name: 'Tc-93m', exemption_level: 10**9, t_medium: 100 },
            { name: 'Tc-94', exemption_level: 10**9, t_medium: 100 },
            { name: 'Tc-94m', exemption_level: 10**9, t_medium: 100 },
            { name: 'Tc-95', exemption_level: 10**9, t_medium: 100 },
            { name: 'Tc-95m', exemption_level: 10**9, t_medium: 100 },
            { name: 'Tc-96', exemption_level: 10**9, t_medium: 100 },
            { name: 'Tc-96m', exemption_level: 10**9, t_medium: 100 },
            { name: 'Tc-97', exemption_level: 10**9, t_medium: 100 },
            { name: 'Tc-97m', exemption_level: 10**9, t_medium: 100 },
            { name: 'Tc-98', exemption_level: 10**9, t_medium: 100 },
            { name: 'Tc-99', exemption_level: 10**9, t_medium: 100 },
            { name: 'Tc-99m', exemption_level: 10**9, t_medium: 100 },
            { name: 'Tc-101', exemption_level: 10**9, t_medium: 100 },
            { name: 'Tc-104', exemption_level: 10**9, t_medium: 100 },
        ]
      },
      { short: 'Ru', long: 'Ruthenium',    mass: 101.07,    category: 2,
        radionuclides: [
            { name: 'Ru-94', exemption_level: 10**9, t_medium: 100 },
            { name: 'Ru-97', exemption_level: 10**9, t_medium: 100 },
            { name: 'Ru-103', exemption_level: 10**9, t_medium: 100 },
            { name: 'Ru-105', exemption_level: 10**9, t_medium: 100 },
            { name: 'Ru-106', exemption_level: 10**9, t_medium: 100 },
        ]
      },
      { short: 'Rh', long: 'Rhodium',      mass: 102.9055,  category: 2,
        radionuclides: [
            { name: 'Rh-99', exemption_level: 10**9, t_medium: 100 },
            { name: 'Rh-99m', exemption_level: 10**9, t_medium: 100 },
            { name: 'Rh-100', exemption_level: 10**9, t_medium: 100 },
            { name: 'Rh-101', exemption_level: 10**9, t_medium: 100 },
            { name: 'Rh-101m', exemption_level: 10**9, t_medium: 100 },
            { name: 'Rh-102', exemption_level: 10**9, t_medium: 100 },
            { name: 'Rh-102m', exemption_level: 10**9, t_medium: 100 },
            { name: 'Rh-103m', exemption_level: 10**9, t_medium: 100 },
            { name: 'Rh-105', exemption_level: 10**9, t_medium: 100 },
            { name: 'Rh-106m', exemption_level: 10**9, t_medium: 100 },
            { name: 'Rh-107', exemption_level: 10**9, t_medium: 100 },
        ]
      },
      { short: 'Pd', long: 'Palladium',    mass: 106.42,    category: 2,
        radionuclides: [
            { name: 'Pd-100', exemption_level: 10**9, t_medium: 100 },
            { name: 'Pd-101', exemption_level: 10**9, t_medium: 100 },
            { name: 'Pd-103', exemption_level: 10**9, t_medium: 100 },
            { name: 'Pd-107', exemption_level: 10**9, t_medium: 100 },
            { name: 'Pd-109', exemption_level: 10**9, t_medium: 100 },
        ]
      },
      { short: 'Ag', long: 'Silver',       mass: 107.8682,  category: 2,
        radionuclides: [
            { name: 'Ag-102', exemption_level: 10**9, t_medium: 100 },
            { name: 'Ag-103', exemption_level: 10**9, t_medium: 100 },
            { name: 'Ag-104', exemption_level: 10**9, t_medium: 100 },
            { name: 'Ag-104m', exemption_level: 10**9, t_medium: 100 },
            { name: 'Ag-105', exemption_level: 10**9, t_medium: 100 },
            { name: 'Ag-106', exemption_level: 10**9, t_medium: 100 },
            { name: 'Ag-106m', exemption_level: 10**9, t_medium: 100 },
            { name: 'Ag-108m', exemption_level: 10**9, t_medium: 100 },
            { name: 'Ag-110m', exemption_level: 10**9, t_medium: 100 },
            { name: 'Ag-111', exemption_level: 10**9, t_medium: 100 },
            { name: 'Ag-112', exemption_level: 10**9, t_medium: 100 },
            { name: 'Ag-115', exemption_level: 10**9, t_medium: 100 },
        ]
      },
      { short: 'Cd', long: 'Cadmium',      mass: 112.411,   category: 2,
        radionuclides: [
            { name: 'Cd-104', exemption_level: 10**9, t_medium: 100 },
            { name: 'Cd-107', exemption_level: 10**9, t_medium: 100 },
            { name: 'Cd-109', exemption_level: 10**9, t_medium: 100 },
            { name: 'Cd-113', exemption_level: 10**9, t_medium: 100 },
            { name: 'Cd-113m', exemption_level: 10**9, t_medium: 100 },
            { name: 'Cd-115', exemption_level: 10**9, t_medium: 100 },
            { name: 'Cd-115m', exemption_level: 10**9, t_medium: 100 },
            { name: 'Cd-117', exemption_level: 10**9, t_medium: 100 },
            { name: 'Cd-117m', exemption_level: 10**9, t_medium: 100 },
        ]
      },
      { short: 'In', long: 'Indium',       mass: 114.818,   category: 3,
        radionuclides: [
            { name: 'In-109', exemption_level: 10**9, t_medium: 100 },
            { name: 'In-110', exemption_level: 10**9, t_medium: 100 },
            { name: 'In-110m', exemption_level: 10**9, t_medium: 100 },
            { name: 'In-111', exemption_level: 10**9, t_medium: 100 },
            { name: 'In-112', exemption_level: 10**9, t_medium: 100 },
            { name: 'In-113m', exemption_level: 10**9, t_medium: 100 },
            { name: 'In-114', exemption_level: 10**9, t_medium: 100 },
            { name: 'In-114m', exemption_level: 10**9, t_medium: 100 },
            { name: 'In-115', exemption_level: 10**9, t_medium: 100 },
            { name: 'In-115m', exemption_level: 10**9, t_medium: 100 },
            { name: 'In-116m', exemption_level: 10**9, t_medium: 100 },
            { name: 'In-117', exemption_level: 10**9, t_medium: 100 },
            { name: 'In-117m', exemption_level: 10**9, t_medium: 100 },
            { name: 'In-119m', exemption_level: 10**9, t_medium: 100 },
        ]
      },
      { short: 'Sn', long: 'Tin',          mass: 118.71,    category: 3,
        radionuclides: [
            { name: 'Sn-110', exemption_level: 10**9, t_medium: 100 },
            { name: 'Sn-111', exemption_level: 10**9, t_medium: 100 },
            { name: 'Sn-113', exemption_level: 10**9, t_medium: 100 },
            { name: 'Sn-117m', exemption_level: 10**9, t_medium: 100 },
            { name: 'Sn-119m', exemption_level: 10**9, t_medium: 100 },
            { name: 'Sn-121', exemption_level: 10**9, t_medium: 100 },
            { name: 'Sn-121m', exemption_level: 10**9, t_medium: 100 },
            { name: 'Sn-123', exemption_level: 10**9, t_medium: 100 },
            { name: 'Sn-123m', exemption_level: 10**9, t_medium: 100 },
            { name: 'Sn-125', exemption_level: 10**9, t_medium: 100 },
            { name: 'Sn-126', exemption_level: 10**9, t_medium: 100 },
            { name: 'Sn-127', exemption_level: 10**9, t_medium: 100 },
            { name: 'Sn-128', exemption_level: 10**9, t_medium: 100 },
        ]
      },    # 50
      { short: 'Sb', long: 'Antimony',     mass: 121.760,   category: 4,
        radionuclides: [
            { name: 'Sb-115', exemption_level: 10**9, t_medium: 100 },
            { name: 'Sb-116', exemption_level: 10**9, t_medium: 100 },
            { name: 'Sb-116m', exemption_level: 10**9, t_medium: 100 },
            { name: 'Sb-117', exemption_level: 10**9, t_medium: 100 },
            { name: 'Sb-118m', exemption_level: 10**9, t_medium: 100 },
            { name: 'Sb-119', exemption_level: 10**9, t_medium: 100 },
            { name: 'Sb-120', exemption_level: 10**9, t_medium: 100 },
            { name: 'Sb-120m', exemption_level: 10**9, t_medium: 100 },
            { name: 'Sb-122', exemption_level: 10**9, t_medium: 100 },
            { name: 'Sb-124', exemption_level: 10**9, t_medium: 100 },
            { name: 'Sb-124m', exemption_level: 10**9, t_medium: 100 },
            { name: 'Sb-125', exemption_level: 10**9, t_medium: 100 },
            { name: 'Sb-126', exemption_level: 10**9, t_medium: 100 },
            { name: 'Sb-126m', exemption_level: 10**9, t_medium: 100 },
            { name: 'Sb-127', exemption_level: 10**9, t_medium: 100 },
            { name: 'Sb-128', exemption_level: 10**9, t_medium: 100 },
            { name: 'Sb-128m', exemption_level: 10**9, t_medium: 100 },
            { name: 'Sb-129', exemption_level: 10**9, t_medium: 100 },
            { name: 'Sb-130', exemption_level: 10**9, t_medium: 100 },
            { name: 'Sb-131', exemption_level: 10**9, t_medium: 100 },
        ]
      },
      { short: 'Te', long: 'Tellurium',    mass: 127.6,     category: 4,
        radionuclides: [
            { name: 'Te-116', exemption_level: 10**9, t_medium: 100 },
            { name: 'Te-121', exemption_level: 10**9, t_medium: 100 },
            { name: 'Te-121m', exemption_level: 10**9, t_medium: 100 },
            { name: 'Te-123', exemption_level: 10**9, t_medium: 100 },
            { name: 'Te-123m', exemption_level: 10**9, t_medium: 100 },
            { name: 'Te-125m', exemption_level: 10**9, t_medium: 100 },
            { name: 'Te-127', exemption_level: 10**9, t_medium: 100 },
            { name: 'Te-127m', exemption_level: 10**9, t_medium: 100 },
            { name: 'Te-129', exemption_level: 10**9, t_medium: 100 },
            { name: 'Te-129m', exemption_level: 10**9, t_medium: 100 },
            { name: 'Te-131', exemption_level: 10**9, t_medium: 100 },
            { name: 'Te-131m', exemption_level: 10**9, t_medium: 100 },
            { name: 'Te-132', exemption_level: 10**9, t_medium: 100 },
            { name: 'Te-133', exemption_level: 10**9, t_medium: 100 },
            { name: 'Te-133m', exemption_level: 10**9, t_medium: 100 },
            { name: 'Te-134', exemption_level: 10**9, t_medium: 100 },
        ]
      },
      { short: 'I',  long: 'Iodine',       mass: 126.90447, category: 6,
        radionuclides: [
            { name: 'I-120', exemption_level: 10**9, t_medium: 100 },
            { name: 'I-120m', exemption_level: 10**9, t_medium: 100 },
            { name: 'I-121', exemption_level: 10**9, t_medium: 100 },
            { name: 'I-123', exemption_level: 10**9, t_medium: 100 },
            { name: 'I-124', exemption_level: 10**9, t_medium: 100 },
            { name: 'I-125', exemption_level: 10**9, t_medium: 100 },
            { name: 'I-126', exemption_level: 10**9, t_medium: 100 },
            { name: 'I-128', exemption_level: 10**9, t_medium: 100 },
            { name: 'I-129', exemption_level: 10**9, t_medium: 100 },
            { name: 'I-130', exemption_level: 10**9, t_medium: 100 },
            { name: 'I-131', exemption_level: 10**9, t_medium: 100 },
            { name: 'I-132', exemption_level: 10**9, t_medium: 100 },
            { name: 'I-132m', exemption_level: 10**9, t_medium: 100 },
            { name: 'I-133', exemption_level: 10**9, t_medium: 100 },
            { name: 'I-134', exemption_level: 10**9, t_medium: 100 },
            { name: 'I-135', exemption_level: 10**9, t_medium: 100 },
        ]
      },
      { short: 'Xe', long: 'Xenon',        mass: 131.29,    category: 7,
        radionuclides: [
            { name: 'Xe-120', exemption_level: 10**9, t_medium: 100 },
            { name: 'Xe-121', exemption_level: 10**9, t_medium: 100 },
            { name: 'Xe-122', exemption_level: 10**9, t_medium: 100 },
            { name: 'Xe-123', exemption_level: 10**9, t_medium: 100 },
            { name: 'Xe-125', exemption_level: 10**9, t_medium: 100 },
            { name: 'Xe-127', exemption_level: 10**9, t_medium: 100 },
            { name: 'Xe-129m', exemption_level: 10**9, t_medium: 100 },
            { name: 'Xe-131m', exemption_level: 10**9, t_medium: 100 },
            { name: 'Xe-133', exemption_level: 10**9, t_medium: 100 },
            { name: 'Xe-133m', exemption_level: 10**9, t_medium: 100 },
            { name: 'Xe-135', exemption_level: 10**9, t_medium: 100 },
            { name: 'Xe-135m', exemption_level: 10**9, t_medium: 100 },
            { name: 'Xe-138', exemption_level: 10**9, t_medium: 100 },
        ]
      },
      { short: 'Cs', long: 'Cesium',       mass: 132.90543, category: 0,
        radionuclides: [
            { name: 'Cs-125', exemption_level: 10**9, t_medium: 100 },
            { name: 'Cs-127', exemption_level: 10**9, t_medium: 100 },
            { name: 'Cs-129', exemption_level: 10**9, t_medium: 100 },
            { name: 'Cs-130', exemption_level: 10**9, t_medium: 100 },
            { name: 'Cs-131', exemption_level: 10**9, t_medium: 100 },
            { name: 'Cs-132', exemption_level: 10**9, t_medium: 100 },
            { name: 'Cs-134', exemption_level: 10**9, t_medium: 100 },
            { name: 'Cs-134m', exemption_level: 10**9, t_medium: 100 },
            { name: 'Cs-135', exemption_level: 10**9, t_medium: 100 },
            { name: 'Cs-135m', exemption_level: 10**9, t_medium: 100 },
            { name: 'Cs-136', exemption_level: 10**9, t_medium: 100 },
            { name: 'Cs-137', exemption_level: 10**9, t_medium: 100 },
            { name: 'Cs-138', exemption_level: 10**9, t_medium: 100 },
        ]
      },
      { short: 'Ba', long: 'Barium',       mass: 137.327,   category: 1,
        radionuclides: [
            { name: 'Ba-126', exemption_level: 10**9, t_medium: 100 },
            { name: 'Ba-128', exemption_level: 10**9, t_medium: 100 },
            { name: 'Ba-131', exemption_level: 10**9, t_medium: 100 },
            { name: 'Ba-131m', exemption_level: 10**9, t_medium: 100 },
            { name: 'Ba-133', exemption_level: 10**9, t_medium: 100 },
            { name: 'Ba-133m', exemption_level: 10**9, t_medium: 100 },
            { name: 'Ba-135m', exemption_level: 10**9, t_medium: 100 },
            { name: 'Ba-137m', exemption_level: 10**9, t_medium: 100 },
            { name: 'Ba-139', exemption_level: 10**9, t_medium: 100 },
            { name: 'Ba-140', exemption_level: 10**9, t_medium: 100 },
            { name: 'Ba-141', exemption_level: 10**9, t_medium: 100 },
            { name: 'Ba-142', exemption_level: 10**9, t_medium: 100 },
        ]
      },

      { short: 'La', long: 'Lanthanum',    mass: 138.9055,  category:  8,
        radionuclides: [
            { name: 'La-131', exemption_level: 10**9, t_medium: 100 },
            { name: 'La-132', exemption_level: 10**9, t_medium: 100 },
            { name: 'La-135', exemption_level: 10**9, t_medium: 100 },
            { name: 'La-137', exemption_level: 10**9, t_medium: 100 },
            { name: 'La-138', exemption_level: 10**9, t_medium: 100 },
            { name: 'La-140', exemption_level: 10**9, t_medium: 100 },
            { name: 'La-141', exemption_level: 10**9, t_medium: 100 },
            { name: 'La-142', exemption_level: 10**9, t_medium: 100 },
            { name: 'La-143', exemption_level: 10**9, t_medium: 100 },
        ]
      },
      { short: 'Ce', long: 'Cerium',       mass: 140.115,   category:  8,
        radionuclides: [
            { name: 'Ce-134', exemption_level: 10**9, t_medium: 100 },
            { name: 'Ce-135', exemption_level: 10**9, t_medium: 100 },
            { name: 'Ce-137', exemption_level: 10**9, t_medium: 100 },
            { name: 'Ce-137m', exemption_level: 10**9, t_medium: 100 },
            { name: 'Ce-139', exemption_level: 10**9, t_medium: 100 },
            { name: 'Ce-141', exemption_level: 10**9, t_medium: 100 },
            { name: 'Ce-143', exemption_level: 10**9, t_medium: 100 },
            { name: 'Ce-144', exemption_level: 10**9, t_medium: 100 },
        ]
      },
      { short: 'Pr', long: 'Praseodymium', mass: 140.90765, category:  8,
        radionuclides: [
            { name: 'Pr-136', exemption_level: 10**9, t_medium: 100 },
            { name: 'Pr-137', exemption_level: 10**9, t_medium: 100 },
            { name: 'Pr-138m', exemption_level: 10**9, t_medium: 100 },
            { name: 'Pr-139', exemption_level: 10**9, t_medium: 100 },
            { name: 'Pr-142', exemption_level: 10**9, t_medium: 100 },
            { name: 'Pr-142m', exemption_level: 10**9, t_medium: 100 },
            { name: 'Pr-143', exemption_level: 10**9, t_medium: 100 },
            { name: 'Pr-144', exemption_level: 10**9, t_medium: 100 },
            { name: 'Pr-145', exemption_level: 10**9, t_medium: 100 },
            { name: 'Pr-147', exemption_level: 10**9, t_medium: 100 },
        ]
      },
      { short: 'Nd', long: 'Neodymium',    mass: 144.24,    category:  8,
        radionuclides: [
            { name: 'Nd-136', exemption_level: 10**9, t_medium: 100 },
            { name: 'Nd-138', exemption_level: 10**9, t_medium: 100 },
            { name: 'Nd-139', exemption_level: 10**9, t_medium: 100 },
            { name: 'Nd-139m', exemption_level: 10**9, t_medium: 100 },
            { name: 'Nd-141', exemption_level: 10**9, t_medium: 100 },
            { name: 'Nd-147', exemption_level: 10**9, t_medium: 100 },
            { name: 'Nd-149', exemption_level: 10**9, t_medium: 100 },
            { name: 'Nd-151', exemption_level: 10**9, t_medium: 100 },
        ]
      },   # 60
      { short: 'Pm', long: 'Promethium',   mass: 144.9127,  category:  8,
        radionuclides: [
            { name: 'Pm-141', exemption_level: 10**9, t_medium: 100 },
            { name: 'Pm-143', exemption_level: 10**9, t_medium: 100 },
            { name: 'Pm-144', exemption_level: 10**9, t_medium: 100 },
            { name: 'Pm-145', exemption_level: 10**9, t_medium: 100 },
            { name: 'Pm-146', exemption_level: 10**9, t_medium: 100 },
            { name: 'Pm-147', exemption_level: 10**9, t_medium: 100 },
            { name: 'Pm-148', exemption_level: 10**9, t_medium: 100 },
            { name: 'Pm-148m', exemption_level: 10**9, t_medium: 100 },
            { name: 'Pm-149', exemption_level: 10**9, t_medium: 100 },
            { name: 'Pm-150', exemption_level: 10**9, t_medium: 100 },
            { name: 'Pm-151', exemption_level: 10**9, t_medium: 100 },
        ]
      },
      { short: 'Sm', long: 'Samarium',     mass: 150.36,    category:  8,
        radionuclides: [
            { name: 'Sm-141', exemption_level: 10**9, t_medium: 100 },
            { name: 'Sm-141m', exemption_level: 10**9, t_medium: 100 },
            { name: 'Sm-142', exemption_level: 10**9, t_medium: 100 },
            { name: 'Sm-145', exemption_level: 10**9, t_medium: 100 },
            { name: 'Sm-146', exemption_level: 10**9, t_medium: 100 },
            { name: 'Sm-147', exemption_level: 10**9, t_medium: 100 },
            { name: 'Sm-151', exemption_level: 10**9, t_medium: 100 },
            { name: 'Sm-153', exemption_level: 10**9, t_medium: 100 },
            { name: 'Sm-155', exemption_level: 10**9, t_medium: 100 },
            { name: 'Sm-156', exemption_level: 10**9, t_medium: 100 },
        ]
      },
      { short: 'Eu', long: 'Europium',     mass: 151.9655,  category:  8,
        radionuclides: [
            { name: 'Eu-145', exemption_level: 10**9, t_medium: 100 },
            { name: 'Eu-146', exemption_level: 10**9, t_medium: 100 },
            { name: 'Eu-147', exemption_level: 10**9, t_medium: 100 },
            { name: 'Eu-148', exemption_level: 10**9, t_medium: 100 },
            { name: 'Eu-149', exemption_level: 10**9, t_medium: 100 },
            { name: 'Eu-150', exemption_level: 10**9, t_medium: 100 },
            { name: 'Eu-150m', exemption_level: 10**9, t_medium: 100 },
            { name: 'Eu-152', exemption_level: 10**9, t_medium: 100 },
            { name: 'Eu-152m', exemption_level: 10**9, t_medium: 100 },
            { name: 'Eu-154', exemption_level: 10**9, t_medium: 100 },
            { name: 'Eu-155', exemption_level: 10**9, t_medium: 100 },
            { name: 'Eu-156', exemption_level: 10**9, t_medium: 100 },
            { name: 'Eu-157', exemption_level: 10**9, t_medium: 100 },
            { name: 'Eu-158', exemption_level: 10**9, t_medium: 100 },
        ]
      },
      { short: 'Gd', long: 'Gadolinium',   mass: 157.25,    category:  8,
        radionuclides: [
            { name: 'Gd-145', exemption_level: 10**9, t_medium: 100 },
            { name: 'Gd-146', exemption_level: 10**9, t_medium: 100 },
            { name: 'Gd-147', exemption_level: 10**9, t_medium: 100 },
            { name: 'Gd-148', exemption_level: 10**9, t_medium: 100 },
            { name: 'Gd-149', exemption_level: 10**9, t_medium: 100 },
            { name: 'Gd-151', exemption_level: 10**9, t_medium: 100 },
            { name: 'Gd-152', exemption_level: 10**9, t_medium: 100 },
            { name: 'Gd-153', exemption_level: 10**9, t_medium: 100 },
            { name: 'Gd-159', exemption_level: 10**9, t_medium: 100 },
        ]
      },
      { short: 'Tb', long: 'Terbium',      mass: 158.92534, category:  8,
        radionuclides: [
            { name: 'Tb-147', exemption_level: 10**9, t_medium: 100 },
            { name: 'Tb-149', exemption_level: 10**9, t_medium: 100 },
            { name: 'Tb-150', exemption_level: 10**9, t_medium: 100 },
            { name: 'Tb-151', exemption_level: 10**9, t_medium: 100 },
            { name: 'Tb-153', exemption_level: 10**9, t_medium: 100 },
            { name: 'Tb-154', exemption_level: 10**9, t_medium: 100 },
            { name: 'Tb-155', exemption_level: 10**9, t_medium: 100 },
            { name: 'Tb-156', exemption_level: 10**9, t_medium: 100 },
            { name: 'Tb-156m', exemption_level: 10**9, t_medium: 100 },
            { name: 'Tb-156mp', exemption_level: 10**9, t_medium: 100 },
            { name: 'Tb-157', exemption_level: 10**9, t_medium: 100 },
            { name: 'Tb-158', exemption_level: 10**9, t_medium: 100 },
            { name: 'Tb-160', exemption_level: 10**9, t_medium: 100 },
            { name: 'Tb-161', exemption_level: 10**9, t_medium: 100 },
        ]
      },
      { short: 'Dy', long: 'Dysprosium',   mass: 162.50,    category:  8,
        radionuclides: [
            { name: 'Dy-155', exemption_level: 10**9, t_medium: 100 },
            { name: 'Dy-157', exemption_level: 10**9, t_medium: 100 },
            { name: 'Dy-159', exemption_level: 10**9, t_medium: 100 },
            { name: 'Dy-165', exemption_level: 10**9, t_medium: 100 },
            { name: 'Dy-166', exemption_level: 10**9, t_medium: 100 },
        ]
      },
      { short: 'Ho', long: 'Holmium',      mass: 164.93032, category:  8,
        radionuclides: [
            { name: 'Ho-155', exemption_level: 10**9, t_medium: 100 },
            { name: 'Ho-157', exemption_level: 10**9, t_medium: 100 },
            { name: 'Ho-159', exemption_level: 10**9, t_medium: 100 },
            { name: 'Ho-161', exemption_level: 10**9, t_medium: 100 },
            { name: 'Ho-162', exemption_level: 10**9, t_medium: 100 },
            { name: 'Ho-162m', exemption_level: 10**9, t_medium: 100 },
            { name: 'Ho-164', exemption_level: 10**9, t_medium: 100 },
            { name: 'Ho-164m', exemption_level: 10**9, t_medium: 100 },
            { name: 'Ho-166', exemption_level: 10**9, t_medium: 100 },
            { name: 'Ho-166m', exemption_level: 10**9, t_medium: 100 },
            { name: 'Ho-167', exemption_level: 10**9, t_medium: 100 },
        ]
      },
      { short: 'Er', long: 'Erbium',       mass: 167.26,    category:  8,
        radionuclides: [
            { name: 'Er-161', exemption_level: 10**9, t_medium: 100 },
            { name: 'Er-165', exemption_level: 10**9, t_medium: 100 },
            { name: 'Er-169', exemption_level: 10**9, t_medium: 100 },
            { name: 'Er-171', exemption_level: 10**9, t_medium: 100 },
            { name: 'Er-172', exemption_level: 10**9, t_medium: 100 },
        ]
      },
      { short: 'Tm', long: 'Thulium',      mass: 168.93421, category:  8,
        radionuclides: [
            { name: 'Tm-162', exemption_level: 10**9, t_medium: 100 },
            { name: 'Tm-166', exemption_level: 10**9, t_medium: 100 },
            { name: 'Tm-167', exemption_level: 10**9, t_medium: 100 },
            { name: 'Tm-170', exemption_level: 10**9, t_medium: 100 },
            { name: 'Tm-171', exemption_level: 10**9, t_medium: 100 },
            { name: 'Tm-172', exemption_level: 10**9, t_medium: 100 },
            { name: 'Tm-173', exemption_level: 10**9, t_medium: 100 },
            { name: 'Tm-175', exemption_level: 10**9, t_medium: 100 },
        ]
      },
      { short: 'Yb', long: 'Ytterbium',    mass: 173.04,    category:  8,
        radionuclides: [
            { name: 'Yb-162', exemption_level: 10**9, t_medium: 100 },
            { name: 'Yb-166', exemption_level: 10**9, t_medium: 100 },
            { name: 'Yb-167', exemption_level: 10**9, t_medium: 100 },
            { name: 'Yb-169', exemption_level: 10**9, t_medium: 100 },
            { name: 'Yb-175', exemption_level: 10**9, t_medium: 100 },
            { name: 'Yb-177', exemption_level: 10**9, t_medium: 100 },
            { name: 'Yb-178', exemption_level: 10**9, t_medium: 100 },
        ]
      },   # 70
      { short: 'Lu', long: 'Lutetium',     mass: 174.967,   category:  8,
        radionuclides: [
            { name: 'Lu-169', exemption_level: 10**9, t_medium: 100 },
            { name: 'Lu-170', exemption_level: 10**9, t_medium: 100 },
            { name: 'Lu-171', exemption_level: 10**9, t_medium: 100 },
            { name: 'Lu-172', exemption_level: 10**9, t_medium: 100 },
            { name: 'Lu-173', exemption_level: 10**9, t_medium: 100 },
            { name: 'Lu-174', exemption_level: 10**9, t_medium: 100 },
            { name: 'Lu-174m', exemption_level: 10**9, t_medium: 100 },
            { name: 'Lu-176', exemption_level: 10**9, t_medium: 100 },
            { name: 'Lu-176m', exemption_level: 10**9, t_medium: 100 },
            { name: 'Lu-177', exemption_level: 10**9, t_medium: 100 },
            { name: 'Lu-177m', exemption_level: 10**9, t_medium: 100 },
            { name: 'Lu-178', exemption_level: 10**9, t_medium: 100 },
            { name: 'Lu-178m', exemption_level: 10**9, t_medium: 100 },
            { name: 'Lu-179', exemption_level: 10**9, t_medium: 100 },
        ]
      },

      { short: 'Hf', long: 'Hafnium',      mass: 178.49,    category:  2,
        radionuclides: [
            { name: 'Hf-170', exemption_level: 10**9, t_medium: 100 },
            { name: 'Hf-172', exemption_level: 10**9, t_medium: 100 },
            { name: 'Hf-173', exemption_level: 10**9, t_medium: 100 },
            { name: 'Hf-175', exemption_level: 10**9, t_medium: 100 },
            { name: 'Hf-177m', exemption_level: 10**9, t_medium: 100 },
            { name: 'Hf-178m', exemption_level: 10**9, t_medium: 100 },
            { name: 'Hf-179m', exemption_level: 10**9, t_medium: 100 },
            { name: 'Hf-180m', exemption_level: 10**9, t_medium: 100 },
            { name: 'Hf-181', exemption_level: 10**9, t_medium: 100 },
            { name: 'Hf-182', exemption_level: 10**9, t_medium: 100 },
            { name: 'Hf-182m', exemption_level: 10**9, t_medium: 100 },
            { name: 'Hf-183', exemption_level: 10**9, t_medium: 100 },
            { name: 'Hf-184', exemption_level: 10**9, t_medium: 100 },
        ]
      },
      { short: 'Ta', long: 'Tantalum',     mass: 180.9479,  category:  2,
        radionuclides: [
            { name: 'Ta-172', exemption_level: 10**9, t_medium: 100 },
            { name: 'Ta-173', exemption_level: 10**9, t_medium: 100 },
            { name: 'Ta-174', exemption_level: 10**9, t_medium: 100 },
            { name: 'Ta-175', exemption_level: 10**9, t_medium: 100 },
            { name: 'Ta-176', exemption_level: 10**9, t_medium: 100 },
            { name: 'Ta-177', exemption_level: 10**9, t_medium: 100 },
            { name: 'Ta-178', exemption_level: 10**9, t_medium: 100 },
            { name: 'Ta-179', exemption_level: 10**9, t_medium: 100 },
            { name: 'Ta-180', exemption_level: 10**9, t_medium: 100 },
            { name: 'Ta-180m', exemption_level: 10**9, t_medium: 100 },
            { name: 'Ta-182', exemption_level: 10**9, t_medium: 100 },
            { name: 'Ta-182m', exemption_level: 10**9, t_medium: 100 },
            { name: 'Ta-183', exemption_level: 10**9, t_medium: 100 },
            { name: 'Ta-184', exemption_level: 10**9, t_medium: 100 },
            { name: 'Ta-185', exemption_level: 10**9, t_medium: 100 },
            { name: 'Ta-186', exemption_level: 10**9, t_medium: 100 },
        ]
      },
      { short: 'W',  long: 'Tungsten',     mass: 183.85,    category:  2,
        radionuclides: [
            { name: 'W-176', exemption_level: 10**9, t_medium: 100 },
            { name: 'W-177', exemption_level: 10**9, t_medium: 100 },
            { name: 'W-178', exemption_level: 10**9, t_medium: 100 },
            { name: 'W-179', exemption_level: 10**9, t_medium: 100 },
            { name: 'W-181', exemption_level: 10**9, t_medium: 100 },
            { name: 'W-185', exemption_level: 10**9, t_medium: 100 },
            { name: 'W-187', exemption_level: 10**9, t_medium: 100 },
            { name: 'W-188', exemption_level: 10**9, t_medium: 100 },
        ]
      },
      { short: 'Re', long: 'Rhenium',      mass: 186.207,   category:  2,
        radionuclides: [
            { name: 'Re-177', exemption_level: 10**9, t_medium: 100 },
            { name: 'Re-178', exemption_level: 10**9, t_medium: 100 },
            { name: 'Re-181', exemption_level: 10**9, t_medium: 100 },
            { name: 'Re-182', exemption_level: 10**9, t_medium: 100 },
            { name: 'Re-182m', exemption_level: 10**9, t_medium: 100 },
            { name: 'Re-184', exemption_level: 10**9, t_medium: 100 },
            { name: 'Re-184m', exemption_level: 10**9, t_medium: 100 },
            { name: 'Re-186', exemption_level: 10**9, t_medium: 100 },
            { name: 'Re-186m', exemption_level: 10**9, t_medium: 100 },
            { name: 'Re-187', exemption_level: 10**9, t_medium: 100 },
            { name: 'Re-188', exemption_level: 10**9, t_medium: 100 },
            { name: 'Re-188m', exemption_level: 10**9, t_medium: 100 },
            { name: 'Re-189', exemption_level: 10**9, t_medium: 100 },
        ]
      },
      { short: 'Os', long: 'Osmium',       mass: 190.23,    category:  2,
        radionuclides: [
            { name: 'Os-180', exemption_level: 10**9, t_medium: 100 },
            { name: 'Os-181', exemption_level: 10**9, t_medium: 100 },
            { name: 'Os-182', exemption_level: 10**9, t_medium: 100 },
            { name: 'Os-185', exemption_level: 10**9, t_medium: 100 },
            { name: 'Os-189m', exemption_level: 10**9, t_medium: 100 },
            { name: 'Os-191', exemption_level: 10**9, t_medium: 100 },
            { name: 'Os-191m', exemption_level: 10**9, t_medium: 100 },
            { name: 'Os-193', exemption_level: 10**9, t_medium: 100 },
            { name: 'Os-194', exemption_level: 10**9, t_medium: 100 },
        ]
      },
      { short: 'Ir', long: 'Iridium',      mass: 192.22,    category:  2,
        radionuclides: [
            { name: 'Ir-182', exemption_level: 10**9, t_medium: 100 },
            { name: 'Ir-184', exemption_level: 10**9, t_medium: 100 },
            { name: 'Ir-185', exemption_level: 10**9, t_medium: 100 },
            { name: 'Ir-186', exemption_level: 10**9, t_medium: 100 },
            { name: 'Ir-186m', exemption_level: 10**9, t_medium: 100 },
            { name: 'Ir-187', exemption_level: 10**9, t_medium: 100 },
            { name: 'Ir-188', exemption_level: 10**9, t_medium: 100 },
            { name: 'Ir-189', exemption_level: 10**9, t_medium: 100 },
            { name: 'Ir-190', exemption_level: 10**9, t_medium: 100 },
            { name: 'Ir-190m', exemption_level: 10**9, t_medium: 100 },
            { name: 'Ir-190mp', exemption_level: 10**9, t_medium: 100 },
            { name: 'Ir-192', exemption_level: 10**9, t_medium: 100 },
            { name: 'Ir-192m', exemption_level: 10**9, t_medium: 100 },
            { name: 'Ir-193m', exemption_level: 10**9, t_medium: 100 },
            { name: 'Ir-194', exemption_level: 10**9, t_medium: 100 },
            { name: 'Ir-194m', exemption_level: 10**9, t_medium: 100 },
            { name: 'Ir-195', exemption_level: 10**9, t_medium: 100 },
            { name: 'Ir-195m', exemption_level: 10**9, t_medium: 100 },
        ]
      },
      { short: 'Pt', long: 'Platinum',     mass: 195.08,    category:  2,
        radionuclides: [
            { name: 'Pt-186', exemption_level: 10**9, t_medium: 100 },
            { name: 'Pt-188', exemption_level: 10**9, t_medium: 100 },
            { name: 'Pt-189', exemption_level: 10**9, t_medium: 100 },
            { name: 'Pt-191', exemption_level: 10**9, t_medium: 100 },
            { name: 'Pt-193', exemption_level: 10**9, t_medium: 100 },
            { name: 'Pt-193m', exemption_level: 10**9, t_medium: 100 },
            { name: 'Pt-195m', exemption_level: 10**9, t_medium: 100 },
            { name: 'Pt-197', exemption_level: 10**9, t_medium: 100 },
            { name: 'Pt-197m', exemption_level: 10**9, t_medium: 100 },
            { name: 'Pt-199', exemption_level: 10**9, t_medium: 100 },
            { name: 'Pt-200', exemption_level: 10**9, t_medium: 100 },
        ]
      },
      { short: 'Au', long: 'Gold',         mass: 196.9665,  category:  2,
        radionuclides: [
            { name: 'Au-193', exemption_level: 10**9, t_medium: 100 },
            { name: 'Au-194', exemption_level: 10**9, t_medium: 100 },
            { name: 'Au-195', exemption_level: 10**9, t_medium: 100 },
            { name: 'Au-198', exemption_level: 10**9, t_medium: 100 },
            { name: 'Au-198m', exemption_level: 10**9, t_medium: 100 },
            { name: 'Au-199', exemption_level: 10**9, t_medium: 100 },
            { name: 'Au-200', exemption_level: 10**9, t_medium: 100 },
            { name: 'Au-200m', exemption_level: 10**9, t_medium: 100 },
            { name: 'Au-201', exemption_level: 10**9, t_medium: 100 },
        ]
      },
      { short: 'Hg', long: 'Mercury',      mass: 200.59,    category:  2,
        radionuclides: [
            { name: 'Hg-193', exemption_level: 10**9, t_medium: 100 },
            { name: 'Hg-193m', exemption_level: 10**9, t_medium: 100 },
            { name: 'Hg-194', exemption_level: 10**9, t_medium: 100 },
            { name: 'Hg-195', exemption_level: 10**9, t_medium: 100 },
            { name: 'Hg-195m', exemption_level: 10**9, t_medium: 100 },
            { name: 'Hg-197', exemption_level: 10**9, t_medium: 100 },
            { name: 'Hg-197m', exemption_level: 10**9, t_medium: 100 },
            { name: 'Hg-199m', exemption_level: 10**9, t_medium: 100 },
            { name: 'Hg-203', exemption_level: 10**9, t_medium: 100 },
        ]
      },   # 80
      { short: 'Tl', long: 'Thallium',     mass: 204.3833,  category:  3,
        radionuclides: [
            { name: 'Tl-194', exemption_level: 10**9, t_medium: 100 },
            { name: 'Tl-194m', exemption_level: 10**9, t_medium: 100 },
            { name: 'Tl-195', exemption_level: 10**9, t_medium: 100 },
            { name: 'Tl-197', exemption_level: 10**9, t_medium: 100 },
            { name: 'Tl-198', exemption_level: 10**9, t_medium: 100 },
            { name: 'Tl-198m', exemption_level: 10**9, t_medium: 100 },
            { name: 'Tl-199', exemption_level: 10**9, t_medium: 100 },
            { name: 'Tl-200', exemption_level: 10**9, t_medium: 100 },
            { name: 'Tl-201', exemption_level: 10**9, t_medium: 100 },
            { name: 'Tl-202', exemption_level: 10**9, t_medium: 100 },
            { name: 'Tl-204', exemption_level: 10**9, t_medium: 100 },
        ]
      },
      { short: 'Pb', long: 'Lead',         mass: 204.3833,  category:  3,
        radionuclides: [
            { name: 'Pb-195m', exemption_level: 10**9, t_medium: 100 },
            { name: 'Pb-198', exemption_level: 10**9, t_medium: 100 },
            { name: 'Pb-199', exemption_level: 10**9, t_medium: 100 },
            { name: 'Pb-200', exemption_level: 10**9, t_medium: 100 },
            { name: 'Pb-201', exemption_level: 10**9, t_medium: 100 },
            { name: 'Pb-202', exemption_level: 10**9, t_medium: 100 },
            { name: 'Pb-202m', exemption_level: 10**9, t_medium: 100 },
            { name: 'Pb-203', exemption_level: 10**9, t_medium: 100 },
            { name: 'Pb-205', exemption_level: 10**9, t_medium: 100 },
            { name: 'Pb-209', exemption_level: 10**9, t_medium: 100 },
            { name: 'Pb-210', exemption_level: 10**9, t_medium: 100 },
            { name: 'Pb-211', exemption_level: 10**9, t_medium: 100 },
            { name: 'Pb-212', exemption_level: 10**9, t_medium: 100 },
            { name: 'Pb-214', exemption_level: 10**9, t_medium: 100 },
        ]
      },
      { short: 'Bi', long: 'Bismuth',      mass: 208.98037, category:  3,
        radionuclides: [
            { name: 'Bi-200', exemption_level: 10**9, t_medium: 100 },
            { name: 'Bi-201', exemption_level: 10**9, t_medium: 100 },
            { name: 'Bi-202', exemption_level: 10**9, t_medium: 100 },
            { name: 'Bi-203', exemption_level: 10**9, t_medium: 100 },
            { name: 'Bi-205', exemption_level: 10**9, t_medium: 100 },
            { name: 'Bi-206', exemption_level: 10**9, t_medium: 100 },
            { name: 'Bi-207', exemption_level: 10**9, t_medium: 100 },
            { name: 'Bi-210', exemption_level: 10**9, t_medium: 100 },
            { name: 'Bi-210m', exemption_level: 10**9, t_medium: 100 },
            { name: 'Bi-212', exemption_level: 10**9, t_medium: 100 },
            { name: 'Bi-213', exemption_level: 10**9, t_medium: 100 },
            { name: 'Bi-214', exemption_level: 10**9, t_medium: 100 },
        ]
      },
      { short: 'Po', long: 'Polonium',     mass: 208.9824,  category:  4,
        radionuclides: [
            { name: 'Po-203', exemption_level: 10**9, t_medium: 100 },
            { name: 'Po-205', exemption_level: 10**9, t_medium: 100 },
            { name: 'Po-206', exemption_level: 10**9, t_medium: 100 },
            { name: 'Po-207', exemption_level: 10**9, t_medium: 100 },
            { name: 'Po-208', exemption_level: 10**9, t_medium: 100 },
            { name: 'Po-209', exemption_level: 10**9, t_medium: 100 },
            { name: 'Po-210', exemption_level: 10**9, t_medium: 100 },
        ]
      },
      { short: 'At', long: 'Astatine',     mass: 209.9871,  category:  6,
        radionuclides: [
            { name: 'At-207', exemption_level: 10**9, t_medium: 100 },
            { name: 'At-211', exemption_level: 10**9, t_medium: 100 },
        ]
      },
      { short: 'Rn', long: 'Radon',        mass: 222.0176,  category:  7,
        radionuclides: [
            { name: 'Rn-220', exemption_level: 10**9, t_medium: 100 },
            { name: 'Rn-222', exemption_level: 10**9, t_medium: 100 },
        ]
      },
      { short: 'Fr', long: 'Francium',     mass: 223.0197,  category:  0,
        radionuclides: [
            { name: 'Fr-222', exemption_level: 10**9, t_medium: 100 },
            { name: 'Fr-223', exemption_level: 10**9, t_medium: 100 },
        ]
      },
      { short: 'Ra', long: 'Radium',       mass: 226.0254,  category:  1,
        radionuclides: [
            { name: 'Ra-223', exemption_level: 10**9, t_medium: 100 },
            { name: 'Ra-224', exemption_level: 10**9, t_medium: 100 },
            { name: 'Ra-225', exemption_level: 10**9, t_medium: 100 },
            { name: 'Ra-226', exemption_level: 10**9, t_medium: 100 },
            { name: 'Ra-227', exemption_level: 10**9, t_medium: 100 },
            { name: 'Ra-228', exemption_level: 10**9, t_medium: 100 },
        ]
      },

      { short: 'Ac', long: 'Actinium',     mass: 227.0278,  category:  9,
        radionuclides: [
            { name: 'Ac-224', exemption_level: 10**9, t_medium: 100 },
            { name: 'Ac-225', exemption_level: 10**9, t_medium: 100 },
            { name: 'Ac-226', exemption_level: 10**9, t_medium: 100 },
            { name: 'Ac-227', exemption_level: 10**9, t_medium: 100 },
            { name: 'Ac-228', exemption_level: 10**9, t_medium: 100 },
        ]
      },
      { short: 'Th', long: 'Thorium',      mass: 232.0381,  category:  9,
        radionuclides: [
            { name: 'Th-226', exemption_level: 10**9, t_medium: 100 },
            { name: 'Th-227', exemption_level: 10**9, t_medium: 100 },
            { name: 'Th-228', exemption_level: 10**9, t_medium: 100 },
            { name: 'Th-229', exemption_level: 10**9, t_medium: 100 },
            { name: 'Th-230', exemption_level: 10**9, t_medium: 100 },
            { name: 'Th-231', exemption_level: 10**9, t_medium: 100 },
            { name: 'Th-232', exemption_level: 10**9, t_medium: 100 },
            { name: 'Th-234', exemption_level: 10**9, t_medium: 100 },
        ]
      },   # 90
      { short: 'Pa', long: 'Protactinium', mass: 231.03588, category:  9,
        radionuclides: [
            { name: 'H-3', exemption_level: 10**9, t_medium: 100 }
        ]
      },
      { short: 'U',  long: 'Uranium',      mass: 238.0289,  category:  9,
        radionuclides: [
            { name: 'H-3', exemption_level: 10**9, t_medium: 100 }
        ]
      },
      { short: 'Np', long: 'Neptunium',    mass: 237.0482,  category:  9,
        radionuclides: [
            { name: 'H-3', exemption_level: 10**9, t_medium: 100 }
        ]
      },
      { short: 'Pu', long: 'Plutonium',    mass: 244.0642,  category:  9,
        radionuclides: [
            { name: 'H-3', exemption_level: 10**9, t_medium: 100 }
        ]
      },
      { short: 'Am', long: 'Americium',    mass: 243.0614,  category:  9,
        radionuclides: [
            { name: 'H-3', exemption_level: 10**9, t_medium: 100 }
        ]
      },
      { short: 'Cm', long: 'Curium',       mass: 247.0703,  category:  9,
        radionuclides: [
            { name: 'H-3', exemption_level: 10**9, t_medium: 100 }
        ]
      },
      { short: 'Bk', long: 'Berkelium',    mass: 247.0703,  category:  9,
        radionuclides: [
            { name: 'H-3', exemption_level: 10**9, t_medium: 100 }
        ]
      },
      { short: 'Cf', long: 'Californium',  mass: 251.0796,  category:  9,
        radionuclides: [
            { name: 'H-3', exemption_level: 10**9, t_medium: 100 }
        ]
      },
      { short: 'Es', long: 'Einsteinium',  mass: 254,       category:  9,
        radionuclides: [
            { name: 'H-3', exemption_level: 10**9, t_medium: 100 }
        ]
      },
      { short: 'Fm', long: 'Fermium',      mass: 257.0951,  category:  9,
        radionuclides: [
            { name: 'H-3', exemption_level: 10**9, t_medium: 100 }
        ]
      },   # 100
      { short: 'Md', long: 'Mendelevium',  mass: 258.1,     category:  9,
        radionuclides: [
            { name: 'H-3', exemption_level: 10**9, t_medium: 100 }
        ]
      },
      { short: 'No', long: 'Nobelium',     mass: 259.1009,  category:  9,
        radionuclides: [
            { name: 'H-3', exemption_level: 10**9, t_medium: 100 }
        ]
      },
      { short: 'Lr', long: 'Lawrencium',   mass: 262,       category:  9,
        radionuclides: [
            { name: 'H-3', exemption_level: 10**9, t_medium: 100 }
        ]
      },

      { short: 'Rf', long: 'Rutherfordium', mass: 261, category: 2,
        radionuclides: [
            { name: 'H-3', exemption_level: 10**9, t_medium: 100 }
        ]
      },
      { short: 'Db', long: 'Dubnium',      mass: 262,       category:  2,
        radionuclides: [
            { name: 'H-3', exemption_level: 10**9, t_medium: 100 }
        ]
      },
      { short: 'Sg', long: 'Seaborgium',   mass: 266,       category:  2,
        radionuclides: [
            { name: 'H-3', exemption_level: 10**9, t_medium: 100 }
        ]
      },
      { short: 'Bh', long: 'Bohrium',      mass: 264,       category:  2,
        radionuclides: [
            { name: 'H-3', exemption_level: 10**9, t_medium: 100 }
        ]
      },
      { short: 'Hs', long: 'Hassium',      mass: 269,       category:  2,
        radionuclides: [
            { name: 'H-3', exemption_level: 10**9, t_medium: 100 }
        ]
      },
      { short: 'Mt', long: 'Meitnerium',   mass: 268,       category:  2,
        radionuclides: [
            { name: 'H-3', exemption_level: 10**9, t_medium: 100 }
        ]
      },
      { short: 'Ds', long: 'Darmstadium',  mass: 269,       category:  2,
        radionuclides: [
            { name: 'H-3', exemption_level: 10**9, t_medium: 100 }
        ]
      },   # 110
      { short: 'Rg', long: 'Roentgenium',  mass: 272,       category:  2,
        radionuclides: [
            { name: 'H-3', exemption_level: 10**9, t_medium: 100 }
        ]
      },
      { short: 'Cn', long: 'Copernicium',  mass: 277,       category:  2,
        radionuclides: [
            { name: 'H-3', exemption_level: 10**9, t_medium: 100 }
        ]
      },
      { short: 'Uut', long: 'Ununtrium', mass: 286, category: 3,
        radionuclides: [
            { name: 'H-3', exemption_level: 10**9, t_medium: 100 }
        ]
      },
      { short: 'Fl', long: 'Flerovium', mass: 289, category: 3,
        radionuclides: [
            { name: 'H-3', exemption_level: 10**9, t_medium: 100 }
        ]
      },
      { short: 'Uup', long: 'Ununpentium', mass: 288, category: 3,
        radionuclides: [
            { name: 'H-3', exemption_level: 10**9, t_medium: 100 }
        ]
      },
      { short: 'Lv', long: 'Livermorium', mass: 293, category: 3,
        radionuclides: [
            { name: 'H-3', exemption_level: 10**9, t_medium: 100 }
        ]
      },
      { short: 'Uus', long: 'Ununseptium',  mass: 294,       category:  6,
        radionuclides: [
            { name: 'H-3', exemption_level: 10**9, t_medium: 100 }
        ]
      },
      { short: 'Uuo', long: 'Ununoctium',   mass: 294,       category:  7,
        radionuclides: [
            { name: 'H-3', exemption_level: 10**9, t_medium: 100 }
        ]
      }, # 118
  ].freeze

  class << self
    def elements(category = nil)
      category ? ELEMENTS.select { |e| e && e[:category] == category } : ELEMENTS
    end

    def element(short)
      ELEMENTS.select { |e| e && e[:short] == short }.first
    end

    def all_radionuclides
      ELEMENTS.compact.map {|e| e[:radionuclides] }.flatten
    end

    def radionuclides(short)
      element(short)[:radionuclides]
    end

    def radionuclide(name)
      all_radionuclides.select{|r| r[:name] == name }.first
    end

    def alkali_metals
      elements(0)
    end

    def alkaline_earth
      elements(1)
    end

    def transition_metals
      elements(2)
    end

    def basic_metals
      elements(3)
    end

    def semi_metals
      elements(4)
    end

    def non_metals
      elements(5)
    end

    def halogens
      elements(6)
    end

    def noble_gases
      elements(7)
    end

    def lanthanides
      elements(8)
    end

    def actinides
      elements(9)
    end
  end
end

module ChemistryRails
  class Railtie < Rails::Railtie
    initializer 'chemistry_rails.active_record' do
      ActiveSupport.on_load :active_record do
        require 'chemistry_rails/orm/activerecord'
      end
    end

    ##
    # Loads the locale files before the Rails application locales
    # letting the Rails application override the locale defaults
    config.before_configuration do
      I18n.load_path << File.join(File.dirname(__FILE__), 'chemistry_rails', 'locale', 'en.yml')
    end
  end
end

module ChemistryRails
  class Formula
    attr_accessor :formula, :elements

    def initialize(formula, options = {})
      @formula = formula
      @options = options
      @elements = Hash[formula.scan(/([A-Z][a-z]{0,2})(\d*)/).map { |k, v| [k, v.blank? ? 1 : v.to_i] }]
    end

    def to_s
      formula
    end

    def empty?
      formula.blank?
    end

    def to_html
      elements.map { |el, i|  "#{el}<sub>#{i > 1 ? i : ''}</sub>" }.join('')
    end

    def to_rich_text
      elements.map { |el, i|  "#{el}#{i.to_s.split('').map { |j| (j.to_i + 8320).chr }.join('') if i > 1}" }.join('')
    end

    def elemental_analysis(_include_oxygen = false)
      return {} unless all_elements_valid?
      mass = elements.map { |el, i| ChemistryRails.element(el)[:mass] * i }.inject { |sum, x| sum + x }

      Hash[
          elements.select { |k, _| %w[C H N S P].include? k }.map do |el, i|
            [el, (ChemistryRails.element(el)[:mass] * i / mass * 100).round(2)]
          end
      ]
    end

    def all_elements_valid?
      elements.all? { |k, _| ChemistryRails.element(k) }
    end
  end
end
