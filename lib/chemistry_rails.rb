require 'cas_number_validator'
module ChemistryRails
  ELEMENT_CATEGORIES = ['Alkali Metal', 'Alkaline Earth', 'Transition Metal', 'Basic Metal', 'Semimetal', 'Nonmetal', 'Halogen', 'Noble gas', 'Lanthanide', 'Actinide'].freeze

  ELEMENTS = [
      nil,
      { short: 'H', long: 'Hydrogen', mass: 1.0079, category: 5,
        radionuclides: [
            { name: 'H-3', exemption_level: 10**9, t_medium: 365 * (12.3), d_value: 2*(10**3)*(10**12) }
        ]
      },
      { short: 'He', long: 'Helium',       mass: 4.00260,   category: 7,
        radionuclides: []
      },
      { short: 'Li', long: 'Lithium',      mass: 6.941,     category: 0,
        radionuclides: []
      },
      { short: 'Be', long: 'Beryllium',    mass: 9.01218,   category: 1,
        radionuclides: [
            { name: 'Be-7', exemption_level: 10**7, t_medium: 53.3, d_value: nil },
            { name: 'Be-10', exemption_level: 10**6, t_medium: 365 * (1.6*(10**6)), d_value: nil }
        ]
      },
      { short: 'B',  long: 'Boron',        mass: 10.811,    category: 4,
        radionuclides: []
      },
      { short: 'C',  long: 'Carbon',       mass: 12.011,    category: 5,
        radionuclides: [
            { name: 'C-11', exemption_level: 10**6, t_medium: (1/24.0) * (0.34), d_value: nil },
            { name: 'C-14', exemption_level: 10**7, t_medium: 365 * (5.73*(10**3)), d_value: nil }
        ]
      },
      { short: 'N',  long: 'Nitrogen',     mass: 14.00674,  category: 5,
        radionuclides: [
            { name: 'N-13', exemption_level: 10**9, t_medium: 9.66 / 60.0 / 24.0, d_value: nil },
        ]
      },
      { short: 'O',  long: 'Oxygen',       mass: 15.9994,   category: 5,
        radionuclides: [
            { name: 'O-15', exemption_level: 10**9, t_medium: 2.04 / 60.0 / 24.0, d_value: nil },
        ]
      },
      { short: 'F',  long: 'Fluorine',     mass: 18.998403, category: 6,
        radionuclides: [
            { name: 'F-18', exemption_level: 10**6, t_medium: (1/24.0) * (1.83), d_value: nil }
        ]
      },
      { short: 'Ne', long: 'Neon',         mass: 20.1797,   category: 7,
        radionuclides: [
            { name: 'Ne-19', exemption_level: 10**9, t_medium: 17.22 / 60.0 / 60.0 / 24.0, d_value: nil },
        ]
      },    # 10
      { short: 'Na', long: 'Sodium',       mass: 22.989768, category: 0,
        radionuclides: [
            { name: 'Na-22', exemption_level: 10**6, t_medium: 365 * (2.60), d_value: nil },
            { name: 'Na-24', exemption_level: 10**5, t_medium: (1/24.0) * (15), d_value: nil }
        ]
      },
      { short: 'Mg', long: 'Magnesium',    mass: 24.305,    category: 1,
        radionuclides: [
            { name: 'Mg-28', exemption_level: 10**5, t_medium: (1/24.0) * (20.9), d_value: nil }
        ]
      },
      { short: 'Al', long: 'Aluminium',    mass: 26.981539, category: 3,
        radionuclides: [
            { name: 'Al-26', exemption_level: 10**5, t_medium: 365 * (7.16*(10**5)), d_value: nil }
        ]
      },
      { short: 'Si', long: 'Silicon',      mass: 28.0855,   category: 4,
        radionuclides: [
            { name: 'Si-31', exemption_level: 10**6, t_medium: (1/24.0) * (2.62), d_value: nil },
            { name: 'Si-32', exemption_level: 10**6, t_medium: 365 * (4.50*(10**2)), d_value: nil }
        ]
      },
      { short: 'P',  long: 'Phosphorus',   mass: 30.973762, category: 5,
        radionuclides: [
            { name: 'P-32', exemption_level: 10**5, t_medium: 14.3, d_value: nil },
            { name: 'P-33', exemption_level: 10**8, t_medium: 25.4, d_value: nil }
        ]
      },
      { short: 'S',  long: 'Sulfur',       mass: 32.066,    category: 5,
        radionuclides: [
            { name: 'S-35', exemption_level: 10**8, t_medium: 87.4, d_value: nil }
        ]
      },
      { short: 'Cl', long: 'Chlorine',     mass: 35.4527,   category: 6,
        radionuclides: [
            { name: 'Cl-36', exemption_level: 10**6, t_medium: 365 * (3.01*(10**5)), d_value: nil },
            { name: 'Cl-38', exemption_level: 10**5, t_medium: (1/24.0) * (0.620), d_value: nil },
            { name: 'Cl-39', exemption_level: 10**5, t_medium: (1/24.0) * (0.927), d_value: nil }
        ]
      },
      { short: 'Ar', long: 'Argon',        mass: 39.948,    category: 7,
        radionuclides: [
            { name: 'Ar-37', exemption_level: 10**8, t_medium: 34.95 / 24.0, d_value: nil },
            { name: 'Ar-39', exemption_level: 10**4, t_medium: 365 * 269.2, d_value: nil },
            { name: 'Ar-41', exemption_level: 10**9, t_medium: 1.83 / 24.0, d_value: nil }
        ]
      },
      { short: 'K',  long: 'Potassium',    mass: 39.0983,   category: 0,
        radionuclides: [
            { name: 'K-40', exemption_level: 10**6, t_medium: 365 * (1.28*(10**9)), d_value: nil },
            { name: 'K-42', exemption_level: 10**6, t_medium: (1/24.0) * (12.4), d_value: nil },
            { name: 'K-43', exemption_level: 10**6, t_medium: (1/24.0) * (22.6), d_value: nil },
            { name: 'K-44', exemption_level: 10**5, t_medium: (1/24.0) * (0.369), d_value: nil },
            { name: 'K-45', exemption_level: 10**5, t_medium: (1/24.0) * (0.333), d_value: nil },
        ]
      },
      { short: 'Ca', long: 'Calcium',      mass: 40.078,    category: 1,
        radionuclides: [
            { name: 'Ca-41', exemption_level: 10**7, t_medium: 365 * (1.40*(10**5)), d_value: nil },
            { name: 'Ca-45', exemption_level: 10**7, t_medium: 136, d_value: nil },
            { name: 'Ca-47', exemption_level: 10**6, t_medium: 4.53, d_value: nil },
        ]
      },    # 20
      { short: 'Sc', long: 'Scandium',     mass: 44.95591,  category: 2,
        radionuclides: [
            { name: 'Sc-43', exemption_level: 10**6, t_medium: (1/24.0) * (3.89), d_value: nil },
            { name: 'Sc-44', exemption_level: 10**5, t_medium: (1/24.0) * (3.93), d_value: nil },
            { name: 'Sc-44m', exemption_level: nil, t_medium: 2.44, d_value: nil },
            { name: 'Sc-45', exemption_level: 10**7, t_medium: nil, d_value: nil },
            { name: 'Sc-46', exemption_level: 10**6, t_medium: 83.8, d_value: nil },
            { name: 'Sc-47', exemption_level: 10**6, t_medium: 3.35, d_value: nil },
            { name: 'Sc-48', exemption_level: 10**5, t_medium: 1.82, d_value: nil },
            { name: 'Sc-49', exemption_level: 10**5, t_medium: (1/24.0) * (0.956), d_value: nil },
        ]
      },
      { short: 'Ti', long: 'Titanium',     mass: 47.88,     category: 2,
        radionuclides: [
            { name: 'Ti-44', exemption_level: 10**5, t_medium: 365 * (47.3), d_value: nil },
            { name: 'Ti-45', exemption_level: 10**6, t_medium: (1/24.0) * (3.08), d_value: nil },
        ]
      },
      { short: 'V',  long: 'Vanadium',     mass: 50.9415,   category: 2,
        radionuclides: [
            { name: 'V-47', exemption_level: 10**5, t_medium: (1/24.0) * (0.543), d_value: nil },
            { name: 'V-48', exemption_level: 10**5, t_medium: 16.2, d_value: nil },
            { name: 'V-49', exemption_level: 10**7, t_medium: 330, d_value: nil },
        ]
      },
      { short: 'Cr', long: 'Chromium',     mass: 51.9961,   category: 2,
        radionuclides: [
            { name: 'Cr-48', exemption_level: 10**6, t_medium: (1/24.0) * (23), d_value: nil },
            { name: 'Cr-49', exemption_level: 10**6, t_medium: (1/24.0) * (0.702), d_value: nil },
            { name: 'Cr-51', exemption_level: 10**7, t_medium: 27.7, d_value: nil },
        ]
      },
      { short: 'Mn', long: 'Manganese',    mass: 54.938,    category: 2,
        radionuclides: [
            { name: 'Mn-51', exemption_level: 10**5, t_medium: (1/24.0) * (0.770), d_value: nil },
            { name: 'Mn-52', exemption_level: 10**5, t_medium: 5.59, d_value: nil },
            { name: 'Mn-52m', exemption_level: 10**5, t_medium: (1/24.0) * (0.352), d_value: nil },
            { name: 'Mn-53', exemption_level: 10**9, t_medium: 365 * (3.70*(10**6)), d_value: nil },
            { name: 'Mn-54', exemption_level: 10**6, t_medium: 312, d_value: nil },
            { name: 'Mn-56', exemption_level: 10**5, t_medium: (1/24.0) * (2.58), d_value: nil },
        ]
      },
      { short: 'Fe', long: 'Iron',         mass: 54.847,    category: 2,
        radionuclides: [
            { name: 'Fe-52', exemption_level: 10**6, t_medium: (1/24.0) * (8.28), d_value: nil },
            { name: 'Fe-55', exemption_level: 10**6, t_medium: 365 * (2.70), d_value: nil },
            { name: 'Fe-59', exemption_level: 10**6, t_medium: 44.5, d_value: nil },
            { name: 'Fe-60', exemption_level: 10**5, t_medium: 365 * (10**5), d_value: nil },
        ]
      },
      { short: 'Co', long: 'Cobalt',       mass: 58.9332,   category: 2,
        radionuclides: [
            { name: 'Co-55', exemption_level: 10**6, t_medium: (1/24.0) * (17.5), d_value: nil },
            { name: 'Co-56', exemption_level: 10**5, t_medium: 78.7, d_value: nil },
            { name: 'Co-57', exemption_level: 10**6, t_medium: 271, d_value: nil },
            { name: 'Co-58', exemption_level: 10**6, t_medium: 70.8, d_value: nil },
            { name: 'Co-58m', exemption_level: 10**7, t_medium: (1/24.0) * (9.15), d_value: nil },
            { name: 'Co-60', exemption_level: 10**5, t_medium: 365 * (5.27), d_value: nil },
            { name: 'Co-60m', exemption_level: 10**6, t_medium: (1/24.0) * (0.174), d_value: nil },
            { name: 'Co-61', exemption_level: 10**6, t_medium: (1/24.0) * (1.65), d_value: nil },
            { name: 'Co-62m', exemption_level: 10**5, t_medium: (1/24.0) * (0.232), d_value: nil },
        ]
      },
      { short: 'Ni', long: 'Nickel',       mass: 58.6934,   category: 2,
        radionuclides: [
            { name: 'Ni-56', exemption_level: 10**6, t_medium: 6.10, d_value: nil },
            { name: 'Ni-57', exemption_level: 10**6, t_medium: 1.50, d_value: nil },
            { name: 'Ni-59', exemption_level: 10**8, t_medium: 365 * (7.50*(10**4)), d_value: nil },
            { name: 'Ni-63', exemption_level: 10**8, t_medium: 365 * (96), d_value: nil },
            { name: 'Ni-65', exemption_level: 10**6, t_medium: (1/24.0) * (2.52), d_value: nil },
            { name: 'Ni-66', exemption_level: 10**7, t_medium: 2.27, d_value: nil },
        ]
      },
      { short: 'Cu', long: 'Copper',       mass: 63.546,    category: 2,
        radionuclides: [
            { name: 'Cu-60', exemption_level: 10**5, t_medium: (1/24.0) * (0.387), d_value: nil },
            { name: 'Cu-61', exemption_level: 10**6, t_medium: (1/24.0) * (3.41), d_value: nil },
            { name: 'Cu-64', exemption_level: 10**6, t_medium: (1/24.0) * (12.7), d_value: nil },
            { name: 'Cu-67', exemption_level: 10**6, t_medium: 2.58 },
        ]
      },
      { short: 'Zn', long: 'Zinc',         mass: 65.39,     category: 2,
        radionuclides: [
            { name: 'Zn-62', exemption_level: 10**6, t_medium: (1/24.0) * (9.26) , d_value: nil},
            { name: 'Zn-63', exemption_level: 10**5, t_medium: (1/24.0) * (0.635) , d_value: nil},
            { name: 'Zn-65', exemption_level: 10**6, t_medium: 244 , d_value: nil},
            { name: 'Zn-69', exemption_level: 10**6, t_medium: (1/24.0) * (0.950) , d_value: nil},
            { name: 'Zn-69m', exemption_level: 10**6, t_medium: (1/24.0) * (13.8) , d_value: nil},
            { name: 'Zn-71m', exemption_level: 10**6, t_medium: (1/24.0) * (3.92) , d_value: nil},
            { name: 'Zn-72', exemption_level: 10**6, t_medium: 1.94 , d_value: nil},
        ]
      },    # 30
      { short: 'Ga', long: 'Gallium',      mass: 69.732,    category: 3,
        radionuclides: [
            { name: 'Ga-65', exemption_level: 10**5, t_medium: (1/24.0) * (0.253) , d_value: nil},
            { name: 'Ga-66', exemption_level: 10**5, t_medium: (1/24.0) * (9.40) , d_value: nil},
            { name: 'Ga-67', exemption_level: 10**6, t_medium: 3.26 , d_value: nil},
            { name: 'Ga-68', exemption_level: 10**5, t_medium: (1/24.0) * (1.13) , d_value: nil},
            { name: 'Ga-70', exemption_level: 10**6, t_medium: (1/24.0) * (0.353) , d_value: nil},
            { name: 'Ga-72', exemption_level: 10**5, t_medium: (1/24.0) * (14.1) , d_value: nil},
            { name: 'Ga-73', exemption_level: 10**6, t_medium: (1/24.0) * (4.91) , d_value: nil},
        ]
      },
      { short: 'Ge', long: 'Germanium',    mass: 72.64,     category: 4,
        radionuclides: [
            { name: 'Ge-66', exemption_level: 10**6, t_medium: (1/24.0) * (2.27) , d_value: nil},
            { name: 'Ge-67', exemption_level: 10**5, t_medium: (1/24.0) * (0.312) , d_value: nil},
            { name: 'Ge-68', exemption_level: 10**5, t_medium: 288 , d_value: nil},
            { name: 'Ge-69', exemption_level: 10**6, t_medium: 1.63 , d_value: nil},
            { name: 'Ge-71', exemption_level: 10**8, t_medium: 11.8 , d_value: nil},
            { name: 'Ge-75', exemption_level: 10**6, t_medium: (1/24.0) * (1.38) , d_value: nil},
            { name: 'Ge-77', exemption_level: 10**5, t_medium: (1/24.0) * (11.3) , d_value: nil},
            { name: 'Ge-78', exemption_level: 10**6, t_medium: (1/24.0) * (1.45) , d_value: nil},
        ]
      },
      { short: 'As', long: 'Arsenic',      mass: 74.92159,  category: 4,
        radionuclides: [
            { name: 'As-69', exemption_level: 10**5, t_medium: (1/24.0) * (0.253) , d_value: nil},
            { name: 'As-70', exemption_level: 10**5, t_medium: (1/24.0) * (0.876) , d_value: nil},
            { name: 'As-71', exemption_level: 10**6, t_medium: 2.70 , d_value: nil},
            { name: 'As-72', exemption_level: 10**5, t_medium: 1.08 , d_value: nil},
            { name: 'As-73', exemption_level: 10**7, t_medium: 80.3 , d_value: nil},
            { name: 'As-74', exemption_level: 10**6, t_medium: 17.8 , d_value: nil},
            { name: 'As-76', exemption_level: 10**5, t_medium: 1.10 , d_value: nil},
            { name: 'As-77', exemption_level: 10**6, t_medium: 1.62 , d_value: nil},
            { name: 'As-78', exemption_level: 10**5, t_medium: (1/24.0) * (1.51) , d_value: nil},
        ]
      },
      { short: 'Se', long: 'Selenium',     mass: 78.96,     category: 5,
        radionuclides: [
            { name: 'Se-70', exemption_level: 10**6, t_medium: (1/24.0) * (0.683) , d_value: nil},
            { name: 'Se-73', exemption_level: 10**6, t_medium: (1/24.0) * (7.15) , d_value: nil},
            { name: 'Se-73m', exemption_level: 10**6, t_medium: (1/24.0) * (0.650) , d_value: nil},
            { name: 'Se-75', exemption_level: 10**6, t_medium: 120 , d_value: nil},
            { name: 'Se-79', exemption_level: 10**7, t_medium: 365 * (6.50*(10**4)) , d_value: nil},
            { name: 'Se-81', exemption_level: 10**6, t_medium: (1/24.0) * (0.308) , d_value: nil},
            { name: 'Se-81m', exemption_level: 10**7, t_medium: (1/24.0) * (0.954) , d_value: nil},
            { name: 'Se-83', exemption_level: 10**5, t_medium: (1/24.0) * (0.375) , d_value: nil},
        ]
      },
      { short: 'Br', long: 'Bromine',      mass: 79.904,    category: 6,
        radionuclides: [
            { name: 'Br-74', exemption_level: 10**5, t_medium: (1/24.0) * (0.422) , d_value: nil},
            { name: 'Br-74m', exemption_level: 10**5, t_medium: (1/24.0) * (0.691) , d_value: nil},
            { name: 'Br-75', exemption_level: 10**6, t_medium: (1/24.0) * (1.63) , d_value: nil},
            { name: 'Br-76', exemption_level: 10**5, t_medium: (1/24.0) * (16.2) , d_value: nil},
            { name: 'Br-77', exemption_level: 10**6, t_medium: 2.33 , d_value: nil},
            { name: 'Br-80', exemption_level: 10**5, t_medium: (1/24.0) * (0.290) , d_value: nil},
            { name: 'Br-80m', exemption_level: 10**7, t_medium: (1/24.0) * (4.42) , d_value: nil},
            { name: 'Br-82', exemption_level: 10**6, t_medium: 1.47 , d_value: nil},
            { name: 'Br-83', exemption_level: 10**6, t_medium: (1/24.0) * (2.39) , d_value: nil},
            { name: 'Br-84', exemption_level: 10**5, t_medium: (1/24.0) * (0.530) , d_value: nil},
        ]
      },
      { short: 'Kr', long: 'Krypton',      mass: 83.80,     category: 7,
        radionuclides: [
            { name: 'Kr-74', exemption_level: 10**9, t_medium: 11.5 / 60.0 / 24.0 , d_value: nil},
            { name: 'Kr-76', exemption_level: 10**9, t_medium: 14.8 / 60.0 / 24.0 , d_value: nil},
            { name: 'Kr-77', exemption_level: 10**9, t_medium: 1.24 / 60.0 / 24.0 , d_value: nil},
            { name: 'Kr-79', exemption_level: 10**5, t_medium: 1.46 / 24.0 , d_value: nil},
            { name: 'Kr-81', exemption_level: 10**7, t_medium: 229261.79 * 365 , d_value: nil},
            { name: 'Kr-81m', exemption_level: 10**10, t_medium: nil , d_value: nil},
            { name: 'Kr-83m', exemption_level: 10**12, t_medium: nil , d_value: nil},
            { name: 'Kr-85', exemption_level: 10**4, t_medium: 10.73 * 365 , d_value: nil},
            { name: 'Kr-85m', exemption_level: 10**10, t_medium: nil , d_value: nil},
            { name: 'Kr-87', exemption_level: 10**9, t_medium: 1.27 / 24.0 , d_value: nil},
            { name: 'Kr-88', exemption_level: 10**9, t_medium: 2.83 / 24.0 , d_value: nil},
        ]
      },
      { short: 'Rb', long: 'Rubidium',     mass: 85.4678,   category: 0,
        radionuclides: [
            { name: 'Rb-79', exemption_level: 10**5, t_medium: (1/24.0) * (0.382) , d_value: nil},
            { name: 'Rb-81', exemption_level: 10**6, t_medium: (1/24.0) * (4.58) , d_value: nil},
            { name: 'Rb-81m', exemption_level: 10**7, t_medium: (1/24.0) * (0.533) , d_value: nil},
            { name: 'Rb-82m', exemption_level: 10**6, t_medium: (1/24.0) * (6.20) , d_value: nil},
            { name: 'Rb-83', exemption_level: 10**6, t_medium: 86.2 , d_value: nil},
            { name: 'Rb-84', exemption_level: 10**6, t_medium: 32.8 , d_value: nil},
            { name: 'Rb-86', exemption_level: 10**5, t_medium: 18.6 , d_value: nil},
            { name: 'Rb-87', exemption_level: 10**7, t_medium: 365 * (4.70*(10**10)) , d_value: nil},
            { name: 'Rb-88', exemption_level: 10**5, t_medium: (1/24.0) * (0.297) , d_value: nil},
            { name: 'Rb-89', exemption_level: 10**5, t_medium: (1/24.0) * (0.253) , d_value: nil},
        ]
      },
      { short: 'Sr', long: 'Strontium',    mass: 87.62,     category: 1,
        radionuclides: [
            { name: 'Sr-80', exemption_level: 10**7, t_medium: (1/24.0) * (1.67) , d_value: nil},
            { name: 'Sr-81', exemption_level: 10**5, t_medium: (1/24.0) * (0.425) , d_value: nil},
            { name: 'Sr-82', exemption_level: 10**5, t_medium: 25 , d_value: nil},
            { name: 'Sr-83', exemption_level: 10**6, t_medium: 1.35 , d_value: nil},
            { name: 'Sr-85', exemption_level: 10**6, t_medium: 64.8 , d_value: nil},
            { name: 'Sr-85m', exemption_level: 10**7, t_medium: (1/24.0) * (1.16) , d_value: nil},
            { name: 'Sr-87m', exemption_level: 10**6, t_medium: (1/24.0) * (2.80) , d_value: nil},
            { name: 'Sr-89', exemption_level: 10**6, t_medium: 50.5 , d_value: nil},
            { name: 'Sr-90', exemption_level: 10**4, t_medium: 365 * (29.1) , d_value: nil},
            { name: 'Sr-91', exemption_level: 10**5, t_medium: (1/24.0) * (9.50) , d_value: nil},
            { name: 'Sr-92', exemption_level: 10**6, t_medium: (1/24.0) * (2.71) , d_value: nil},
        ]
      },
      { short: 'Y',  long: 'Yttrium',      mass: 88.90585,  category: 2,
        radionuclides: [
            { name: 'Y-86', exemption_level: 10**5, t_medium: (1/24.0) * (14.7) , d_value: nil},
            { name: 'Y-86m', exemption_level: 10**7, t_medium: (1/24.0) * (0.800) , d_value: nil},
            { name: 'Y-87', exemption_level: 10**6, t_medium: 3.35 , d_value: nil},
            { name: 'Y-88', exemption_level: 10**6, t_medium: 107 , d_value: nil},
            { name: 'Y-90', exemption_level: 10**5, t_medium: 2.67 , d_value: nil},
            { name: 'Y-90m', exemption_level: 10**6, t_medium: (1/24.0) * (3.19) , d_value: nil},
            { name: 'Y-91', exemption_level: 10**6, t_medium: 58.5 , d_value: nil},
            { name: 'Y-91m', exemption_level: 10**6, t_medium: (1/24.0) * (0.828) , d_value: nil},
            { name: 'Y-92', exemption_level: 10**5, t_medium: (1/24.0) * (3.54) , d_value: nil},
            { name: 'Y-93', exemption_level: 10**5, t_medium: (1/24.0) * (10.1) , d_value: nil},
            { name: 'Y-94', exemption_level: 10**5, t_medium: (1/24.0) * (0.318) , d_value: nil},
            { name: 'Y-95', exemption_level: 10**5, t_medium: (1/24.0) * (0.178) , d_value: nil},
        ]
      },
      { short: 'Zr', long: 'Zirconium',    mass: 91.224,    category: 2,
        radionuclides: [
            { name: 'Zr-86', exemption_level: 10**7, t_medium: (1/24.0) * (16.5) , d_value: nil},
            { name: 'Zr-88', exemption_level: 10**6, t_medium: 83.4 , d_value: nil},
            { name: 'Zr-89', exemption_level: 10**6, t_medium: 3.27 , d_value: nil},
            { name: 'Zr-93', exemption_level: 10**7, t_medium: 365 * (1.53*(10**6)) , d_value: nil},
            { name: 'Zr-95', exemption_level: 10**6, t_medium: 64 , d_value: nil},
            { name: 'Zr-97', exemption_level: 10**5, t_medium: (1/24.0) * (16.9) , d_value: nil},
        ]
      },    # 40
      { short: 'Nb', long: 'Niobium',      mass: 92.90638,  category: 2,
        radionuclides: [
            { name: 'Nb-88', exemption_level: 10**5, t_medium: (1/24.0) * (0.238) , d_value: nil},
            { name: 'Nb-89', exemption_level: 10**5, t_medium: (1/24.0) * (2.03) , d_value: nil},
            { name: 'Nb-89m', exemption_level: 10**5, t_medium: (1/24.0) * (1.10) , d_value: nil},
            { name: 'Nb-90', exemption_level: 10**5, t_medium: (1/24.0) * (14.6) , d_value: nil},
            { name: 'Nb-93m', exemption_level: 10**7, t_medium: 365 * (13.6) , d_value: nil},
            { name: 'Nb-94', exemption_level: 10**6, t_medium: 365 * (2.03*(10**4)) , d_value: nil},
            { name: 'Nb-95', exemption_level: 10**6, t_medium: 35.1 , d_value: nil},
            { name: 'Nb-95m', exemption_level: 10**7, t_medium: 3.61 , d_value: nil},
            { name: 'Nb-96', exemption_level: 10**5, t_medium: (1/24.0) * (23.3) , d_value: nil},
            { name: 'Nb-97', exemption_level: 10**6, t_medium: (1/24.0) * (1.20) , d_value: nil},
            { name: 'Nb-98', exemption_level: 10**5, t_medium: (1/24.0) * (0.858) , d_value: nil},
        ]
      },
      { short: 'Mo', long: 'Molybdenum',   mass: 95.94,     category: 2,
        radionuclides: [
            { name: 'Mo-90', exemption_level: 10**6, t_medium: (1/24.0) * (5.67) , d_value: nil},
            { name: 'Mo-93', exemption_level: 10**8, t_medium: 365 * (3.50*(10**3)) , d_value: nil},
            { name: 'Mo-93m', exemption_level: 10**6, t_medium: (1/24.0) * (6.85) , d_value: nil},
            { name: 'Mo-99', exemption_level: 10**6, t_medium: 2.75 , d_value: nil},
            { name: 'Mo-101', exemption_level: 10**6, t_medium: (1/24.0) * (0.244) , d_value: nil},
        ]
      },
      { short: 'Tc', long: 'Technetium',   mass: 98.9072,   category: 2,
        radionuclides: [
            { name: 'Tc-93', exemption_level: 10**6, t_medium: (1/24.0) * (2.75) , d_value: nil},
            { name: 'Tc-93m', exemption_level: 10**6, t_medium: (1/24.0) * (0.725) , d_value: nil},
            { name: 'Tc-94', exemption_level: 10**6, t_medium: (1/24.0) * (4.88) , d_value: nil},
            { name: 'Tc-94m', exemption_level: 10**5, t_medium: (1/24.0) * (0.867) , d_value: nil},
            { name: 'Tc-95', exemption_level: 10**6, t_medium: (1/24.0) * (20.0) , d_value: nil},
            { name: 'Tc-95m', exemption_level: 10**6, t_medium: 61 , d_value: nil},
            { name: 'Tc-96', exemption_level: 10**6, t_medium: 4.28 , d_value: nil},
            { name: 'Tc-96m', exemption_level: 10**7, t_medium: (1/24.0) * (0.858) , d_value: nil},
            { name: 'Tc-97', exemption_level: 10**8, t_medium: 365 * (2.60*(10**6)) , d_value: nil},
            { name: 'Tc-97m', exemption_level: 10**7, t_medium: 87 , d_value: nil},
            { name: 'Tc-98', exemption_level: 10**6, t_medium: 365 * (4.20*(10**6)) , d_value: nil},
            { name: 'Tc-99', exemption_level: 10**7, t_medium: 365 * (2.13*(10**5)) , d_value: nil},
            { name: 'Tc-99m', exemption_level: 10**7, t_medium: (1/24.0) * (6.02) , d_value: nil},
            { name: 'Tc-101', exemption_level: 10**6, t_medium: (1/24.0) * (0.237) , d_value: nil},
            { name: 'Tc-104', exemption_level: 10**5, t_medium: (1/24.0) * (0.303) , d_value: nil},
        ]
      },
      { short: 'Ru', long: 'Ruthenium',    mass: 101.07,    category: 2,
        radionuclides: [
            { name: 'Ru-94', exemption_level: 10**6, t_medium: (1/24.0) * (0.863) , d_value: nil},
            { name: 'Ru-97', exemption_level: 10**7, t_medium: 2.90 , d_value: nil},
            { name: 'Ru-103', exemption_level: 10**6, t_medium: 39.3 , d_value: nil},
            { name: 'Ru-105', exemption_level: 10**6, t_medium: (1/24.0) * (4.44) , d_value: nil},
            { name: 'Ru-106', exemption_level: 10**5, t_medium: 365 * (1.01) , d_value: nil},
        ]
      },
      { short: 'Rh', long: 'Rhodium',      mass: 102.9055,  category: 2,
        radionuclides: [
            { name: 'Rh-99', exemption_level: 10**6, t_medium: 16.0 , d_value: nil},
            { name: 'Rh-99m', exemption_level: 10**6, t_medium: (1/24.0) * (4.70) , d_value: nil},
            { name: 'Rh-100', exemption_level: 10**6, t_medium: (1/24.0) * (20.8) , d_value: nil},
            { name: 'Rh-101', exemption_level: 10**7, t_medium: 365 * (3.20) , d_value: nil},
            { name: 'Rh-101m', exemption_level: 10**7, t_medium: 4.34 , d_value: nil},
            { name: 'Rh-102', exemption_level: 10**6, t_medium: 365 * (2.90) , d_value: nil},
            { name: 'Rh-102m', exemption_level: 10**6, t_medium: 207 , d_value: nil},
            { name: 'Rh-103m', exemption_level: 10**8, t_medium: (1/24.0) * (0.935) , d_value: nil},
            { name: 'Rh-105', exemption_level: 10**7, t_medium: 1.97 , d_value: nil},
            { name: 'Rh-106m', exemption_level: 10**5, t_medium: (1/24.0) * (2.20) , d_value: nil},
            { name: 'Rh-107', exemption_level: 10**6, t_medium: (1/24.0) * (0.362) , d_value: nil},
        ]
      },
      { short: 'Pd', long: 'Palladium',    mass: 106.42,    category: 2,
        radionuclides: [
            { name: 'Pd-100', exemption_level: 10**7, t_medium: 3.63 , d_value: nil},
            { name: 'Pd-101', exemption_level: 10**6, t_medium: (1/24.0) * (8.27) , d_value: nil},
            { name: 'Pd-103', exemption_level: 10**8, t_medium: 17 , d_value: nil},
            { name: 'Pd-107', exemption_level: 10**8, t_medium: 365 * (6.50*(10**6)) , d_value: nil},
            { name: 'Pd-109', exemption_level: 10**6, t_medium: (1/24.0) * (13.4) , d_value: nil},
        ]
      },
      { short: 'Ag', long: 'Silver',       mass: 107.8682,  category: 2,
        radionuclides: [
            { name: 'Ag-102', exemption_level: 10**5, t_medium: (1/24.0) * (0.215) , d_value: nil},
            { name: 'Ag-103', exemption_level: 10**6, t_medium: (1/24.0) * (1.09) , d_value: nil},
            { name: 'Ag-104', exemption_level: 10**6, t_medium: (1/24.0) * (1.15) , d_value: nil},
            { name: 'Ag-104m', exemption_level: 10**6, t_medium: (1/24.0) * (0.558) , d_value: nil},
            { name: 'Ag-105', exemption_level: 10**6, t_medium: 41 , d_value: nil},
            { name: 'Ag-106', exemption_level: 10**6, t_medium: (1/24.0) * (0.399) , d_value: nil},
            { name: 'Ag-106m', exemption_level: 10**6, t_medium: 8.41 , d_value: nil},
            { name: 'Ag-108m', exemption_level: 10**6, t_medium: 365 * (1.27*(10**2)) , d_value: nil},
            { name: 'Ag-110m', exemption_level: 10**6, t_medium: 250 , d_value: nil},
            { name: 'Ag-111', exemption_level: 10**6, t_medium: 7.45 , d_value: nil},
            { name: 'Ag-112', exemption_level: 10**5, t_medium: (1/24.0) * (3.12) , d_value: nil},
            { name: 'Ag-115', exemption_level: 10**5, t_medium: (1/24.0) * (3.33) , d_value: nil},
        ]
      },
      { short: 'Cd', long: 'Cadmium',      mass: 112.411,   category: 2,
        radionuclides: [
            { name: 'Cd-104', exemption_level: 10**7, t_medium: (1/24.0) * (0.961) , d_value: nil},
            { name: 'Cd-107', exemption_level: 10**7, t_medium: (1/24.0) * (6.49) , d_value: nil},
            { name: 'Cd-109', exemption_level: 10**6, t_medium: 365 * (1.27) , d_value: nil},
            { name: 'Cd-113', exemption_level: 10**6, t_medium: 365 * (9.30*(10**15)) , d_value: nil},
            { name: 'Cd-113m', exemption_level: 10**6, t_medium: 365 * (13.6) , d_value: nil},
            { name: 'Cd-115', exemption_level: 10**6, t_medium: 2.23 , d_value: nil},
            { name: 'Cd-115m', exemption_level: 10**6, t_medium: 44.6 , d_value: nil},
            { name: 'Cd-117', exemption_level: 10**6, t_medium: (1/24.0) * (2.49) , d_value: nil},
            { name: 'Cd-117m', exemption_level: 10**6, t_medium: (1/24.0) * (3.36) , d_value: nil},
        ]
      },
      { short: 'In', long: 'Indium',       mass: 114.818,   category: 3,
        radionuclides: [
            { name: 'In-109', exemption_level: 10**6, t_medium: (1/24.0) * (4.20) , d_value: nil},
            { name: 'In-110', exemption_level: 10**6, t_medium: (1/24.0) * (4.90) , d_value: nil},
            { name: 'In-110m', exemption_level: 10**5, t_medium: (1/24.0) * (1.15) , d_value: nil},
            { name: 'In-111', exemption_level: 10**6, t_medium: 2.83 , d_value: nil},
            { name: 'In-112', exemption_level: 10**6, t_medium: (1/24.0) * (0.240) , d_value: nil},
            { name: 'In-113m', exemption_level: 10**6, t_medium: (1/24.0) * (1.66) , d_value: nil},
            { name: 'In-114', exemption_level: 10**5, t_medium: 1.2 / 60.0 / 24.0 , d_value: nil},
            { name: 'In-114m', exemption_level: 10**6, t_medium: 49.5 , d_value: nil},
            { name: 'In-115', exemption_level: 10**5, t_medium: 365 * (5.10*(10**15)) , d_value: nil},
            { name: 'In-115m', exemption_level: 10**6, t_medium: (1/24.0) * (4.49) , d_value: nil},
            { name: 'In-116m', exemption_level: 10**5, t_medium: (1/24.0) * (0.902) , d_value: nil},
            { name: 'In-117', exemption_level: 10**6, t_medium: (1/24.0) * (0.730) , d_value: nil},
            { name: 'In-117m', exemption_level: 10**6, t_medium: (1/24.0) * (1.94) , d_value: nil},
            { name: 'In-119m', exemption_level: 10**5, t_medium: (1/24.0) * (0.300) , d_value: nil},
        ]
      },
      { short: 'Sn', long: 'Tin',          mass: 118.71,    category: 3,
        radionuclides: [
            { name: 'Sn-110', exemption_level: 10**7, t_medium: (1/24.0) * (4) , d_value: nil},
            { name: 'Sn-111', exemption_level: 10**6, t_medium: (1/24.0) * (0.588) , d_value: nil},
            { name: 'Sn-113', exemption_level: 10**7, t_medium: 115 , d_value: nil},
            { name: 'Sn-117m', exemption_level: 10**6, t_medium: 13.6 , d_value: nil},
            { name: 'Sn-119m', exemption_level: 10**7, t_medium: 293 , d_value: nil},
            { name: 'Sn-121', exemption_level: 10**7, t_medium: 1.13 , d_value: nil},
            { name: 'Sn-121m', exemption_level: 10**7, t_medium: 365 * (55) , d_value: nil},
            { name: 'Sn-123', exemption_level: 10**6, t_medium: 129 , d_value: nil},
            { name: 'Sn-123m', exemption_level: 10**6, t_medium: (1/24.0) * (0.668) , d_value: nil},
            { name: 'Sn-125', exemption_level: 10**5, t_medium: 9.64 , d_value: nil},
            { name: 'Sn-126', exemption_level: 10**5, t_medium: 365 * (10**5) , d_value: nil},
            { name: 'Sn-127', exemption_level: 10**6, t_medium: (1/24.0) * (2.10) , d_value: nil},
            { name: 'Sn-128', exemption_level: 10**6, t_medium: (1/24.0) * (0.985) , d_value: nil},
        ]
      },    # 50
      { short: 'Sb', long: 'Antimony',     mass: 121.760,   category: 4,
        radionuclides: [
            { name: 'Sb-115', exemption_level: 10**6, t_medium: (1/24.0) * (0.530) , d_value: nil},
            { name: 'Sb-116', exemption_level: 10**6, t_medium: (1/24.0) * (0.263) , d_value: nil},
            { name: 'Sb-116m', exemption_level: 10**5, t_medium: (1/24.0) * (1) , d_value: nil},
            { name: 'Sb-117', exemption_level: 10**7, t_medium: (1/24.0) * (2.80) , d_value: nil},
            { name: 'Sb-118m', exemption_level: 10**6, t_medium: (1/24.0) * (5) , d_value: nil},
            { name: 'Sb-119', exemption_level: 10**7, t_medium: 1.59 , d_value: nil},
            { name: 'Sb-120', exemption_level: 10**6, t_medium: (1/24.0) * (0.265) , d_value: nil},
            { name: 'Sb-120m', exemption_level: 10**6, t_medium: 5.76 , d_value: nil},
            { name: 'Sb-122', exemption_level: 10**4, t_medium: 2.70 , d_value: nil},
            { name: 'Sb-124', exemption_level: 10**6, t_medium: 60.2 , d_value: nil},
            { name: 'Sb-124m', exemption_level: 10**6, t_medium: (1/24.0) * (0.337) , d_value: nil},
            { name: 'Sb-125', exemption_level: 10**6, t_medium: 365 * (2.77) , d_value: nil},
            { name: 'Sb-126', exemption_level: 10**5, t_medium: 12.4 , d_value: nil},
            { name: 'Sb-126m', exemption_level: 10**5, t_medium: (1/24.0) * (0.317) , d_value: nil},
            { name: 'Sb-127', exemption_level: 10**6, t_medium: 3.85 , d_value: nil},
            { name: 'Sb-128', exemption_level: 10**5, t_medium: (1/24.0) * (9.01) , d_value: nil},
            { name: 'Sb-128m', exemption_level: 10**5, t_medium: (1/24.0) * (0.173) , d_value: nil},
            { name: 'Sb-129', exemption_level: 10**6, t_medium: (1/24.0) * (4.32) , d_value: nil},
            { name: 'Sb-130', exemption_level: 10**5, t_medium: (1/24.0) * (0.667) , d_value: nil},
            { name: 'Sb-131', exemption_level: 10**6, t_medium: (1/24.0) * (0.383) , d_value: nil},
        ]
      },
      { short: 'Te', long: 'Tellurium',    mass: 127.6,     category: 4,
        radionuclides: [
            { name: 'Te-116', exemption_level: 10**7, t_medium: (1/24.0) * (2.49) , d_value: nil},
            { name: 'Te-121', exemption_level: 10**6, t_medium: 17 , d_value: nil},
            { name: 'Te-121m', exemption_level: 10**6, t_medium: 154 , d_value: nil},
            { name: 'Te-123', exemption_level: 10**6, t_medium: 365 * (10**13) , d_value: nil},
            { name: 'Te-123m', exemption_level: 10**7, t_medium: 120 , d_value: nil},
            { name: 'Te-125m', exemption_level: 10**7, t_medium: 58 , d_value: nil},
            { name: 'Te-127', exemption_level: 10**6, t_medium: (1/24.0) * (9.35) , d_value: nil},
            { name: 'Te-127m', exemption_level: 10**7, t_medium: 109 , d_value: nil},
            { name: 'Te-129', exemption_level: 10**6, t_medium: (1/24.0) *  1.16 , d_value: nil},
            { name: 'Te-129m', exemption_level: 10**6, t_medium: 33.6 , d_value: nil},
            { name: 'Te-131', exemption_level: 10**5, t_medium: (1/24.0) *  0.417 , d_value: nil},
            { name: 'Te-131m', exemption_level: 10**6, t_medium: 1.25 , d_value: nil},
            { name: 'Te-132', exemption_level: 10**7, t_medium: 3.26 , d_value: nil},
            { name: 'Te-133', exemption_level: 10**5, t_medium: (1/24.0) *  0.207 , d_value: nil},
            { name: 'Te-133m', exemption_level: 10**5, t_medium: (1/24.0) *  0.923 , d_value: nil},
            { name: 'Te-134', exemption_level: 10**6, t_medium: (1/24.0) *  0.696 , d_value: nil},
        ]
      },
      { short: 'I',  long: 'Iodine',       mass: 126.90447, category: 6,
        radionuclides: [
            { name: 'I-120', exemption_level: 10**5, t_medium: (1/24.0) *  1.35 , d_value: nil},
            { name: 'I-120m', exemption_level: 10**5, t_medium: (1/24.0) *  0.883 , d_value: nil},
            { name: 'I-121', exemption_level: 10**6, t_medium: (1/24.0) *  2.12 , d_value: nil},
            { name: 'I-123', exemption_level: 10**7, t_medium: (1/24.0) *  13.2 , d_value: nil},
            { name: 'I-124', exemption_level: 10**6, t_medium: 4.18 , d_value: nil},
            { name: 'I-125', exemption_level: 10**6, t_medium: 60.1 , d_value: nil},
            { name: 'I-126', exemption_level: 10**6, t_medium: 13 , d_value: nil},
            { name: 'I-128', exemption_level: 10**5, t_medium: (1/24.0) *  0.416 , d_value: nil},
            { name: 'I-129', exemption_level: 10**5, t_medium: 365 *  1.57*(10**7) , d_value: nil},
            { name: 'I-130', exemption_level: 10**6, t_medium: (1/24.0) *  12.4 , d_value: nil},
            { name: 'I-131', exemption_level: 10**6, t_medium: 8.04 , d_value: nil},
            { name: 'I-132', exemption_level: 10**5, t_medium: (1/24.0) *  2.30 , d_value: nil},
            { name: 'I-132m', exemption_level: 10**6, t_medium: (1/24.0) *  1.39 , d_value: nil},
            { name: 'I-133', exemption_level: 10**6, t_medium: (1/24.0) *  20.8 , d_value: nil},
            { name: 'I-134', exemption_level: 10**5, t_medium: (1/24.0) *  0.876 , d_value: nil},
            { name: 'I-135', exemption_level: 10**6, t_medium: (1/24.0) *  6.61 , d_value: nil},
        ]
      },
      { short: 'Xe', long: 'Xenon',        mass: 131.29,    category: 7,
        radionuclides: [
            { name: 'Xe-120', exemption_level: 10**9, t_medium: 40 / 60.0 / 24.0 , d_value: nil},
            { name: 'Xe-121', exemption_level: 10**9, t_medium: 40.17 / 60.0 / 24.0 , d_value: nil},
            { name: 'Xe-122', exemption_level: 10**9, t_medium: 20.11 / 60.0 / 24.0 , d_value: nil},
            { name: 'Xe-123', exemption_level: 10**9, t_medium: 2.08 / 24.0 , d_value: nil},
            { name: 'Xe-125', exemption_level: 10**9, t_medium: 16.89 / 24.0 , d_value: nil},
            { name: 'Xe-127', exemption_level: 10**5, t_medium: 36.34 , d_value: nil},
            { name: 'Xe-129m', exemption_level: 10**4, t_medium: nil , d_value: nil},
            { name: 'Xe-131m', exemption_level: 10**4, t_medium: nil , d_value: nil},
            { name: 'Xe-133', exemption_level: 10**4, t_medium: 5.24 , d_value: nil},
            { name: 'Xe-133m', exemption_level: 10**4, t_medium: nil , d_value: nil},
            { name: 'Xe-135', exemption_level: 10**10, t_medium: 9.14 / 24.0 , d_value: nil},
            { name: 'Xe-135m', exemption_level: 10**9, t_medium: nil , d_value: nil},
            { name: 'Xe-138', exemption_level: 10**9, t_medium: 14.08 / 60.0 / 24.0 , d_value: nil},
        ]
      },
      { short: 'Cs', long: 'Cesium',       mass: 132.90543, category: 0,
        radionuclides: [
            { name: 'Cs-125', exemption_level: 10**4, t_medium: (1/24.0) * (0.750) , d_value: nil},
            { name: 'Cs-127', exemption_level: 10**5, t_medium: (1/24.0) * (6.25) , d_value: nil},
            { name: 'Cs-129', exemption_level: 10**5, t_medium: 1.34 , d_value: nil},
            { name: 'Cs-130', exemption_level: 10**6, t_medium: (1/24.0) * (0.498) , d_value: nil},
            { name: 'Cs-131', exemption_level: 10**6, t_medium: 9.69 , d_value: nil},
            { name: 'Cs-132', exemption_level: 10**5, t_medium: 6.48 , d_value: nil},
            { name: 'Cs-134', exemption_level: 10**5, t_medium: 365 * (2.06) , d_value: nil},
            { name: 'Cs-134m', exemption_level: 10**4, t_medium: (1/24.0) * (2.90) , d_value: nil},
            { name: 'Cs-135', exemption_level: 10**7, t_medium: 365 * (2.30*(10**6)) , d_value: nil},
            { name: 'Cs-135m', exemption_level: 10**6, t_medium: (1/24.0) * (0.883) , d_value: nil},
            { name: 'Cs-136', exemption_level: 10**5, t_medium: 13.1 , d_value: nil},
            { name: 'Cs-137', exemption_level: 10**4, t_medium: 365 * (30) , d_value: nil},
            { name: 'Cs-138', exemption_level: 10**4, t_medium: (1/24.0) * (0.536) , d_value: nil},
        ]
      },
      { short: 'Ba', long: 'Barium',       mass: 137.327,   category: 1,
        radionuclides: [
            { name: 'Ba-126', exemption_level: 10**7, t_medium: (1/24.0) * (1.61) , d_value: nil},
            { name: 'Ba-128', exemption_level: 10**7, t_medium: 2.43 , d_value: nil},
            { name: 'Ba-131', exemption_level: 10**6, t_medium: 11.8 , d_value: nil},
            { name: 'Ba-131m', exemption_level: 10**7, t_medium: (1/24.0) * (0.243) , d_value: nil},
            { name: 'Ba-133', exemption_level: 10**6, t_medium: 365 * (10.7) , d_value: nil},
            { name: 'Ba-133m', exemption_level: 10**6, t_medium: 1.62 , d_value: nil},
            { name: 'Ba-135m', exemption_level: 10**6, t_medium: 1.20 , d_value: nil},
            { name: 'Ba-137m', exemption_level: 10**6, t_medium: nil , d_value: nil},
            { name: 'Ba-139', exemption_level: 10**5, t_medium: (1/24.0) * (1.38) , d_value: nil},
            { name: 'Ba-140', exemption_level: 10**5, t_medium: 12.7 , d_value: nil},
            { name: 'Ba-141', exemption_level: 10**5, t_medium: (1/24.0) * (0.305) , d_value: nil},
            { name: 'Ba-142', exemption_level: 10**2, t_medium: (1/24.0) * (0.177) , d_value: nil},
        ]
      },

      { short: 'La', long: 'Lanthanum',    mass: 138.9055,  category:  8,
        radionuclides: [
            { name: 'La-131', exemption_level: 10**6, t_medium: (1/24.0) * (0.983) , d_value: nil},
            { name: 'La-132', exemption_level: 10**6, t_medium: (1/24.0) * (4.80) , d_value: nil},
            { name: 'La-135', exemption_level: 10**7, t_medium: (1/24.0) * (19.5) , d_value: nil},
            { name: 'La-137', exemption_level: 10**7, t_medium: 365 * (6*(10**4)) , d_value: nil},
            { name: 'La-138', exemption_level: 10**6, t_medium: 365 * (1.35*(10**11)) , d_value: nil},
            { name: 'La-140', exemption_level: 10**5, t_medium: 1.68 , d_value: nil},
            { name: 'La-141', exemption_level: 10**5, t_medium: (1/24.0) * (3.93) , d_value: nil},
            { name: 'La-142', exemption_level: 10**5, t_medium: (1/24.0) * (1.54) , d_value: nil},
            { name: 'La-143', exemption_level: 10**5, t_medium: (1/24.0) * (0.237) , d_value: nil},
        ]
      },
      { short: 'Ce', long: 'Cerium',       mass: 140.115,   category:  8,
        radionuclides: [
            { name: 'Ce-134', exemption_level: 10**7, t_medium: 3 , d_value: nil},
            { name: 'Ce-135', exemption_level: 10**6, t_medium: (1/24.0) * (17.6) , d_value: nil},
            { name: 'Ce-137', exemption_level: 10**7, t_medium: (1/24.0) * (9) , d_value: nil},
            { name: 'Ce-137m', exemption_level: 10**6, t_medium: 1.43 , d_value: nil},
            { name: 'Ce-139', exemption_level: 10**6, t_medium: 138 , d_value: nil},
            { name: 'Ce-141', exemption_level: 10**7, t_medium: 32.5 , d_value: nil},
            { name: 'Ce-143', exemption_level: 10**6, t_medium: 1.38 , d_value: nil},
            { name: 'Ce-144', exemption_level: 10**5, t_medium: 284 , d_value: nil},
        ]
      },
      { short: 'Pr', long: 'Praseodymium', mass: 140.90765, category:  8,
        radionuclides: [
            { name: 'Pr-136', exemption_level: 10**5, t_medium: (1/24.0) * (0.218) , d_value: nil},
            { name: 'Pr-137', exemption_level: 10**6, t_medium: (1/24.0) * (1.28) , d_value: nil},
            { name: 'Pr-138m', exemption_level: 10**6, t_medium: (1/24.0) * (2.10) , d_value: nil},
            { name: 'Pr-139', exemption_level: 10**7, t_medium: (1/24.0) * (4.51) , d_value: nil},
            { name: 'Pr-142', exemption_level: 10**5, t_medium: (1/24.0) * (19.1) , d_value: nil},
            { name: 'Pr-142m', exemption_level: 10**9, t_medium: (1/24.0) * (0.243) , d_value: nil},
            { name: 'Pr-143', exemption_level: 10**6, t_medium: 13.6 , d_value: nil},
            { name: 'Pr-144', exemption_level: 10**5, t_medium: (1/24.0) * (0.288) , d_value: nil},
            { name: 'Pr-145', exemption_level: 10**5, t_medium: (1/24.0) * (5.98) , d_value: nil},
            { name: 'Pr-147', exemption_level: 10**5, t_medium: (1/24.0) * (0.227) , d_value: nil},
        ]
      },
      { short: 'Nd', long: 'Neodymium',    mass: 144.24,    category:  8,
        radionuclides: [
            { name: 'Nd-136', exemption_level: 10**6, t_medium: (1/24.0) * (0.844) , d_value: nil},
            { name: 'Nd-138', exemption_level: 10**7, t_medium: (1/24.0) * (5.04) , d_value: nil},
            { name: 'Nd-139', exemption_level: 10**6, t_medium: (1/24.0) * (0.495) , d_value: nil},
            { name: 'Nd-139m', exemption_level: 10**6, t_medium: (1/24.0) * (5.50) , d_value: nil},
            { name: 'Nd-141', exemption_level: 10**7, t_medium: (1/24.0) * (2.49) , d_value: nil},
            { name: 'Nd-147', exemption_level: 10**6, t_medium: 11 , d_value: nil},
            { name: 'Nd-149', exemption_level: 10**6, t_medium: (1/24.0) * (1.73) , d_value: nil},
            { name: 'Nd-151', exemption_level: 10**5, t_medium: (1/24.0) * (0.207) , d_value: nil},
        ]
      },   # 60
      { short: 'Pm', long: 'Promethium',   mass: 144.9127,  category:  8,
        radionuclides: [
            { name: 'Pm-141', exemption_level: 10**5, t_medium: (1/24.0) * (0.348) , d_value: nil},
            { name: 'Pm-143', exemption_level: 10**6, t_medium: 265 , d_value: nil},
            { name: 'Pm-144', exemption_level: 10**6, t_medium: 363 , d_value: nil},
            { name: 'Pm-145', exemption_level: 10**7, t_medium: 365 * (17.7) , d_value: nil},
            { name: 'Pm-146', exemption_level: 10**6, t_medium: 365 * (5.53) , d_value: nil},
            { name: 'Pm-147', exemption_level: 10**7, t_medium: 365 * (2.62) , d_value: nil},
            { name: 'Pm-148', exemption_level: 10**5, t_medium: 5.37 , d_value: nil},
            { name: 'Pm-148m', exemption_level: 10**6, t_medium: 41.3 , d_value: nil},
            { name: 'Pm-149', exemption_level: 10**6, t_medium: 2.21 , d_value: nil},
            { name: 'Pm-150', exemption_level: 10**5, t_medium: (1/24.0) * (2.68) , d_value: nil},
            { name: 'Pm-151', exemption_level: 10**6, t_medium: 1.18 , d_value: nil},
        ]
      },
      { short: 'Sm', long: 'Samarium',     mass: 150.36,    category:  8,
        radionuclides: [
            { name: 'Sm-141', exemption_level: 10**5, t_medium: (1/24.0) * (0.170) , d_value: nil},
            { name: 'Sm-141m', exemption_level: 10**6, t_medium: (1/24.0) * (0.377) , d_value: nil},
            { name: 'Sm-142', exemption_level: 10**7, t_medium: (1/24.0) * (1.21) , d_value: nil},
            { name: 'Sm-145', exemption_level: 10**7, t_medium: 340 , d_value: nil},
            { name: 'Sm-146', exemption_level: 10**5, t_medium: 365 * (1.03*(10**8)) , d_value: nil},
            { name: 'Sm-147', exemption_level: 10**4, t_medium: 365 * (1.06*(10**11)) , d_value: nil},
            { name: 'Sm-151', exemption_level: 10**8, t_medium: 365 * (90) , d_value: nil},
            { name: 'Sm-153', exemption_level: 10**6, t_medium: 1.95 , d_value: nil},
            { name: 'Sm-155', exemption_level: 10**6, t_medium: (1/24.0) * (0.368) , d_value: nil},
            { name: 'Sm-156', exemption_level: 10**6, t_medium: (1/24.0) * (9.40) , d_value: nil},
        ]
      },
      { short: 'Eu', long: 'Europium',     mass: 151.9655,  category:  8,
        radionuclides: [
            { name: 'Eu-145', exemption_level: 10**6, t_medium: 5.94 , d_value: nil},
            { name: 'Eu-146', exemption_level: 10**6, t_medium: 4.61 , d_value: nil},
            { name: 'Eu-147', exemption_level: 10**6, t_medium: 24 , d_value: nil},
            { name: 'Eu-148', exemption_level: 10**6, t_medium: 54.5 , d_value: nil},
            { name: 'Eu-149', exemption_level: 10**7, t_medium: 93.1 , d_value: nil},
            { name: 'Eu-150', exemption_level: 10**6, t_medium: 365 * (34.2) , d_value: nil},
            { name: 'Eu-150m', exemption_level: 10**6, t_medium: (1/24.0) * (12.6) , d_value: nil},
            { name: 'Eu-152', exemption_level: 10**6, t_medium: 365 * (13.3) , d_value: nil},
            { name: 'Eu-152m', exemption_level: 10**6, t_medium: (1/24.0) * (9.32) , d_value: nil},
            { name: 'Eu-154', exemption_level: 10**6, t_medium: 365 * (8.80) , d_value: nil},
            { name: 'Eu-155', exemption_level: 10**7, t_medium: 365 * (4.96) , d_value: nil},
            { name: 'Eu-156', exemption_level: 10**6, t_medium: 15.2 , d_value: nil},
            { name: 'Eu-157', exemption_level: 10**6, t_medium: (1/24.0) * (15.1) , d_value: nil},
            { name: 'Eu-158', exemption_level: 10**5, t_medium: (1/24.0) * (0.765) , d_value: nil},
        ]
      },
      { short: 'Gd', long: 'Gadolinium',   mass: 157.25,    category:  8,
        radionuclides: [
            { name: 'Gd-145', exemption_level: 10**5, t_medium: (1/24.0) * (0.382) , d_value: nil},
            { name: 'Gd-146', exemption_level: 10**6, t_medium: 48.3 , d_value: nil},
            { name: 'Gd-147', exemption_level: 10**6, t_medium: 1.59 , d_value: nil},
            { name: 'Gd-148', exemption_level: 10**4, t_medium: 365 * (93) , d_value: nil},
            { name: 'Gd-149', exemption_level: 10**6, t_medium: 9.4 , d_value: nil},
            { name: 'Gd-151', exemption_level: 10**7, t_medium: 120 , d_value: nil},
            { name: 'Gd-152', exemption_level: 10**4, t_medium: 365 * (1.08*(10**14)) , d_value: nil},
            { name: 'Gd-153', exemption_level: 10**7, t_medium: 242 , d_value: nil},
            { name: 'Gd-159', exemption_level: 10**6, t_medium: (1/24.0) * (18.6) , d_value: nil},
        ]
      },
      { short: 'Tb', long: 'Terbium',      mass: 158.92534, category:  8,
        radionuclides: [
            { name: 'Tb-147', exemption_level: 10**6, t_medium: (1/24.0) * (1.65) , d_value: nil},
            { name: 'Tb-149', exemption_level: 10**6, t_medium: (1/24.0) * (4.15) , d_value: nil},
            { name: 'Tb-150', exemption_level: 10**6, t_medium: (1/24.0) * (3.27) , d_value: nil},
            { name: 'Tb-151', exemption_level: 10**6, t_medium: (1/24.0) * (17.6) , d_value: nil},
            { name: 'Tb-153', exemption_level: 10**7, t_medium: 2.34 , d_value: nil},
            { name: 'Tb-154', exemption_level: 10**6, t_medium: (1/24.0) * (21.4) , d_value: nil},
            { name: 'Tb-155', exemption_level: 10**7, t_medium: 5.32 , d_value: nil},
            { name: 'Tb-156', exemption_level: 10**6, t_medium: 5.34 , d_value: nil},
            { name: 'Tb-156m', exemption_level: 10**7, t_medium: 1.02 , d_value: nil},
            { name: 'Tb-156mp', exemption_level: 10**7, t_medium: (1/24.0) * (5) , d_value: nil},
            { name: 'Tb-157', exemption_level: 10**7, t_medium: 365 * (7.1*10) , d_value: nil},
            { name: 'Tb-158', exemption_level: 10**6, t_medium: 365 * (1.80*(10**2)) , d_value: nil},
            { name: 'Tb-160', exemption_level: 10**6, t_medium: 72.3 , d_value: nil},
            { name: 'Tb-161', exemption_level: 10**6, t_medium: 6.91 , d_value: nil},
        ]
      },
      { short: 'Dy', long: 'Dysprosium',   mass: 162.50,    category:  8,
        radionuclides: [
            { name: 'Dy-155', exemption_level: 10**6, t_medium: (1/24.0) * (10) , d_value: nil},
            { name: 'Dy-157', exemption_level: 10**6, t_medium: (1/24.0) * (8.10) , d_value: nil},
            { name: 'Dy-159', exemption_level: 10**7, t_medium: 144 , d_value: nil},
            { name: 'Dy-165', exemption_level: 10**6, t_medium: (1/24.0) * (2.33) , d_value: nil},
            { name: 'Dy-166', exemption_level: 10**6, t_medium: 3.40 , d_value: nil},
        ]
      },
      { short: 'Ho', long: 'Holmium',      mass: 164.93032, category:  8,
        radionuclides: [
            { name: 'Ho-155', exemption_level: 10**6, t_medium: (1/24.0) * (0.800) , d_value: nil},
            { name: 'Ho-157', exemption_level: 10**6, t_medium: (1/24.0) * (0.210) , d_value: nil},
            { name: 'Ho-159', exemption_level: 10**6, t_medium: (1/24.0) * (0.550) , d_value: nil},
            { name: 'Ho-161', exemption_level: 10**7, t_medium: (1/24.0) * (2.50) , d_value: nil},
            { name: 'Ho-162', exemption_level: 10**7, t_medium: (1/24.0) * (0.250) , d_value: nil},
            { name: 'Ho-162m', exemption_level: 10**6, t_medium: (1/24.0) * (1.13) , d_value: nil},
            { name: 'Ho-164', exemption_level: 10**6, t_medium: (1/24.0) * (0.483) , d_value: nil},
            { name: 'Ho-164m', exemption_level: 10**7, t_medium: (1/24.0) * (0.625) , d_value: nil},
            { name: 'Ho-166', exemption_level: 10**5, t_medium: 1.12 , d_value: nil},
            { name: 'Ho-166m', exemption_level: 10**6, t_medium: 365 * (1.20*(10**3)) , d_value: nil},
            { name: 'Ho-167', exemption_level: 10**6, t_medium: (1/24.0) * (3.10) , d_value: nil},
        ]
      },
      { short: 'Er', long: 'Erbium',       mass: 167.26,    category:  8,
        radionuclides: [
            { name: 'Er-161', exemption_level: 10**6, t_medium: (1/24.0) * (3.24) , d_value: nil},
            { name: 'Er-165', exemption_level: 10**7, t_medium: (1/24.0) * (10.4) , d_value: nil},
            { name: 'Er-169', exemption_level: 10**7, t_medium: 9.30 , d_value: nil},
            { name: 'Er-171', exemption_level: 10**6, t_medium: (1/24.0) * (7.52) , d_value: nil},
            { name: 'Er-172', exemption_level: 10**6, t_medium: 2.05 , d_value: nil},
        ]
      },
      { short: 'Tm', long: 'Thulium',      mass: 168.93421, category:  8,
        radionuclides: [
            { name: 'Tm-162', exemption_level: 10**6, t_medium: (1/24.0) * (0.362) , d_value: nil},
            { name: 'Tm-166', exemption_level: 10**7, t_medium: (1/24.0) * (7.70) , d_value: nil},
            { name: 'Tm-167', exemption_level: 10**6, t_medium: 9.24 , d_value: nil},
            { name: 'Tm-170', exemption_level: 10**6, t_medium: 129 , d_value: nil},
            { name: 'Tm-171', exemption_level: 10**8, t_medium: 365 * (1.92) , d_value: nil},
            { name: 'Tm-172', exemption_level: 10**6, t_medium: 2.65 , d_value: nil},
            { name: 'Tm-173', exemption_level: 10**6, t_medium: (1/24.0) * (8.24) , d_value: nil},
            { name: 'Tm-175', exemption_level: 10**6, t_medium: (1/24.0) * (0.253) , d_value: nil},
        ]
      },
      { short: 'Yb', long: 'Ytterbium',    mass: 173.04,    category:  8,
        radionuclides: [
            { name: 'Yb-162', exemption_level: 10**7, t_medium: (1/24.0) * (0.315) , d_value: nil},
            { name: 'Yb-166', exemption_level: 10**7, t_medium: 2.36 , d_value: nil},
            { name: 'Yb-167', exemption_level: 10**6, t_medium: (1/24.0) * (0.292) , d_value: nil},
            { name: 'Yb-169', exemption_level: 10**7, t_medium: 32 , d_value: nil},
            { name: 'Yb-175', exemption_level: 10**7, t_medium: 4.19 , d_value: nil},
            { name: 'Yb-177', exemption_level: 10**6, t_medium: (1/24.0) * (1.90) , d_value: nil},
            { name: 'Yb-178', exemption_level: 10**6, t_medium: (1/24.0) * (1.23) , d_value: nil},
        ]
      },   # 70
      { short: 'Lu', long: 'Lutetium',     mass: 174.967,   category:  8,
        radionuclides: [
            { name: 'Lu-169', exemption_level: 10**6, t_medium: 1.42 , d_value: nil},
            { name: 'Lu-170', exemption_level: 10**6, t_medium: 2.0 , d_value: nil},
            { name: 'Lu-171', exemption_level: 10**6, t_medium: 8.22 , d_value: nil},
            { name: 'Lu-172', exemption_level: 10**6, t_medium: 6.70 , d_value: nil},
            { name: 'Lu-173', exemption_level: 10**7, t_medium: 365 * (1.37) , d_value: nil},
            { name: 'Lu-174', exemption_level: 10**7, t_medium: 365 * (3.31) , d_value: nil},
            { name: 'Lu-174m', exemption_level: 10**7, t_medium: 142.0 , d_value: nil},
            { name: 'Lu-176', exemption_level: 10**6, t_medium: 365 * (3.60*(10**10)) , d_value: nil},
            { name: 'Lu-176m', exemption_level: 10**6, t_medium: (1/24.0) * (3.68) , d_value: nil},
            { name: 'Lu-177', exemption_level: 10**7, t_medium: 6.71 , d_value: nil},
            { name: 'Lu-177m', exemption_level: 10**6, t_medium: 161.0 , d_value: nil},
            { name: 'Lu-178', exemption_level: 10**5, t_medium: (1/24.0) * (0.473) , d_value: nil},
            { name: 'Lu-178m', exemption_level: 10**5, t_medium: (1/24.0) * (0.378) , d_value: nil},
            { name: 'Lu-179', exemption_level: 10**6, t_medium: (1/24.0) * (4.59) , d_value: nil},
        ]
      },

      { short: 'Hf', long: 'Hafnium',      mass: 178.49,    category:  2,
        radionuclides: [
            { name: 'Hf-170', exemption_level: 10**6, t_medium: (1/24.0) * (16.0) , d_value: nil},
            { name: 'Hf-172', exemption_level: 10**6, t_medium: 365 * (1.87) , d_value: nil},
            { name: 'Hf-173', exemption_level: 10**6, t_medium: (1/24.0) * (24.0) , d_value: nil},
            { name: 'Hf-175', exemption_level: 10**6, t_medium: 70.0 , d_value: nil},
            { name: 'Hf-177m', exemption_level: 10**5, t_medium: (1/24.0) * (0.856) , d_value: nil},
            { name: 'Hf-178m', exemption_level: 10**6, t_medium: 365 * (31.0) , d_value: nil},
            { name: 'Hf-179m', exemption_level: 10**6, t_medium: 25.1 , d_value: nil},
            { name: 'Hf-180m', exemption_level: 10**6, t_medium: (1/24.0) * (5.50) , d_value: nil},
            { name: 'Hf-181', exemption_level: 10**6, t_medium: 42.4 , d_value: nil},
            { name: 'Hf-182', exemption_level: 10**6, t_medium: 365 * (9.0*(10**6)) , d_value: nil},
            { name: 'Hf-182m', exemption_level: 10**6, t_medium: (1/24.0) * (1.02) , d_value: nil},
            { name: 'Hf-183', exemption_level: 10**6, t_medium: (1/24.0) * (1.07) , d_value: nil},
            { name: 'Hf-184', exemption_level: 10**6, t_medium: (1/24.0) * (4.12) , d_value: nil},
        ]
      },
      { short: 'Ta', long: 'Tantalum',     mass: 180.9479,  category:  2,
        radionuclides: [
            { name: 'Ta-172', exemption_level: 10**6, t_medium: (1/24.0) * (0.613) , d_value: nil},
            { name: 'Ta-173', exemption_level: 10**6, t_medium: (1/24.0) * (3.65) , d_value: nil},
            { name: 'Ta-174', exemption_level: 10**6, t_medium: (1/24.0) * (1.20) , d_value: nil},
            { name: 'Ta-175', exemption_level: 10**6, t_medium: (1/24.0) * (10.5) , d_value: nil},
            { name: 'Ta-176', exemption_level: 10**6, t_medium: (1/24.0) * (8.08) , d_value: nil},
            { name: 'Ta-177', exemption_level: 10**7, t_medium: 2.36 , d_value: nil},
            { name: 'Ta-178', exemption_level: 10**6, t_medium: (1/24.0) * (2.20) , d_value: nil},
            { name: 'Ta-179', exemption_level: 10**7, t_medium: 365 * (1.82) , d_value: nil},
            { name: 'Ta-180', exemption_level: 10**6, t_medium: 365 * (10**13) , d_value: nil},
            { name: 'Ta-180m', exemption_level: 10**7, t_medium: (1/24.0) * (8.10) , d_value: nil},
            { name: 'Ta-182', exemption_level: 10**4, t_medium: 115.0 , d_value: nil},
            { name: 'Ta-182m', exemption_level: 10**6, t_medium: (1/24.0) * (0.264) , d_value: nil},
            { name: 'Ta-183', exemption_level: 10**6, t_medium: 5.10 , d_value: nil},
            { name: 'Ta-184', exemption_level: 10**6, t_medium: (1/24.0) * (8.70) , d_value: nil},
            { name: 'Ta-185', exemption_level: 10**5, t_medium: (1/24.0) * (0.816) , d_value: nil},
            { name: 'Ta-186', exemption_level: 10**5, t_medium: (1/24.0) * (0.175) , d_value: nil},
        ]
      },
      { short: 'W',  long: 'Tungsten',     mass: 183.85,    category:  2,
        radionuclides: [
            { name: 'W-176', exemption_level: 10**6, t_medium: (1/24.0) * (2.30) , d_value: nil},
            { name: 'W-177', exemption_level: 10**6, t_medium: (1/24.0) * (2.25) , d_value: nil},
            { name: 'W-178', exemption_level: 10**6, t_medium: 21.7 , d_value: nil},
            { name: 'W-179', exemption_level: 10**7, t_medium: (1/24.0) * (0.625) , d_value: nil},
            { name: 'W-181', exemption_level: 10**7, t_medium: 121.0 , d_value: nil},
            { name: 'W-185', exemption_level: 10**7, t_medium: 75.1 , d_value: nil},
            { name: 'W-187', exemption_level: 10**6, t_medium: (1/24.0) * (23.9) , d_value: nil},
            { name: 'W-188', exemption_level: 10**5, t_medium: 69.4 , d_value: nil},
        ]
      },
      { short: 'Re', long: 'Rhenium',      mass: 186.207,   category:  2,
        radionuclides: [
            { name: 'Re-177', exemption_level: 10**6, t_medium: (1/24.0) * (0.233) , d_value: nil},
            { name: 'Re-178', exemption_level: 10**6, t_medium: (1/24.0) * (0.220) , d_value: nil},
            { name: 'Re-181', exemption_level: 10**6, t_medium: (1/24.0) * (20.0) , d_value: nil},
            { name: 'Re-182', exemption_level: 10**6, t_medium: 2.67 , d_value: nil},
            { name: 'Re-182m', exemption_level: 10**6, t_medium: (1/24.0) * (12.7) , d_value: nil},
            { name: 'Re-184', exemption_level: 10**6, t_medium: 38.0 , d_value: nil},
            { name: 'Re-184m', exemption_level: 10**6, t_medium: 165.0 , d_value: nil},
            { name: 'Re-186', exemption_level: 10**6, t_medium: 3.78 , d_value: nil},
            { name: 'Re-186m', exemption_level: 10**7, t_medium: 365 * (2.0*(10**5)) , d_value: nil},
            { name: 'Re-187', exemption_level: 10**9, t_medium: 365 * (5.0*(10**10)) , d_value: nil},
            { name: 'Re-188', exemption_level: 10**5, t_medium: (1/24.0) * (17.0) , d_value: nil},
            { name: 'Re-188m', exemption_level: 10**7, t_medium: (1/24.0) * (0.3) , d_value: nil},
            { name: 'Re-189', exemption_level: 10**6, t_medium: 1.01 , d_value: nil},
        ]
      },
      { short: 'Os', long: 'Osmium',       mass: 190.23,    category:  2,
        radionuclides: [
            { name: 'Os-180', exemption_level: 10**7, t_medium: (1/24.0) * (0.366) , d_value: nil},
            { name: 'Os-181', exemption_level: 10**6, t_medium: (1/24.0) * (1.75) , d_value: nil},
            { name: 'Os-182', exemption_level: 10**6, t_medium: (1/24.0) * (22.0) , d_value: nil},
            { name: 'Os-185', exemption_level: 10**6, t_medium: 94.0 , d_value: nil},
            { name: 'Os-189m', exemption_level: 10**7, t_medium: (1/24.0) * (6.0) , d_value: nil},
            { name: 'Os-191', exemption_level: 10**7, t_medium: 15.4 , d_value: nil},
            { name: 'Os-191m', exemption_level: 10**7, t_medium: (1/24.0) * (13.0) , d_value: nil},
            { name: 'Os-193', exemption_level: 10**6, t_medium: 1.25 , d_value: nil},
            { name: 'Os-194', exemption_level: 10**5, t_medium: 365 * (6.0) , d_value: nil},
        ]
      },
      { short: 'Ir', long: 'Iridium',      mass: 192.22,    category:  2,
        radionuclides: [
            { name: 'Ir-182', exemption_level: 10**5, t_medium: (1/24.0) * (0.250) , d_value: nil},
            { name: 'Ir-184', exemption_level: 10**6, t_medium: (1/24.0) * (3.2) , d_value: nil},
            { name: 'Ir-185', exemption_level: 10**6, t_medium: (1/24.0) * (14.0) , d_value: nil},
            { name: 'Ir-186', exemption_level: 10**6, t_medium: (1/24.0) * (15.8) , d_value: nil},
            { name: 'Ir-186m', exemption_level: 10**6, t_medium: (1/24.0) * (1.75) , d_value: nil},
            { name: 'Ir-187', exemption_level: 10**6, t_medium: (1/24.0) * (10.5) , d_value: nil},
            { name: 'Ir-188', exemption_level: 10**6, t_medium: 1.73 , d_value: nil},
            { name: 'Ir-189', exemption_level: 10**7, t_medium: 13.3 , d_value: nil},
            { name: 'Ir-190', exemption_level: 10**6, t_medium: 12.1 , d_value: nil},
            { name: 'Ir-190m', exemption_level: 10**6, t_medium: (1/24.0) * (3.10) , d_value: nil},
            { name: 'Ir-190mp', exemption_level: 10**7, t_medium: (1/24.0) * (1.20) , d_value: nil},
            { name: 'Ir-192', exemption_level: 10**4, t_medium: 74.0 , d_value: nil},
            { name: 'Ir-192m', exemption_level: 10**7, t_medium: 365 * (2.41*(10**2)) , d_value: nil},
            { name: 'Ir-193m', exemption_level: 10**7, t_medium: 11.9 , d_value: nil},
            { name: 'Ir-194', exemption_level: 10**5, t_medium: (1/24.0) * (19.1) , d_value: nil},
            { name: 'Ir-194m', exemption_level: 10**6, t_medium: 171.0 , d_value: nil},
            { name: 'Ir-195', exemption_level: 10**6, t_medium: (1/24.0) * (2.50) , d_value: nil},
            { name: 'Ir-195m', exemption_level: 10**6, t_medium: (1/24.0) * (3.80) , d_value: nil},
        ]
      },
      { short: 'Pt', long: 'Platinum',     mass: 195.08,    category:  2,
        radionuclides: [
            { name: 'Pt-186', exemption_level: 10**6, t_medium: (1/24.0) * (2.0) , d_value: nil},
            { name: 'Pt-188', exemption_level: 10**6, t_medium: 10.2 , d_value: nil},
            { name: 'Pt-189', exemption_level: 10**6, t_medium: (1/24.0) * (10.9) , d_value: nil},
            { name: 'Pt-191', exemption_level: 10**6, t_medium: 2.80 , d_value: nil},
            { name: 'Pt-193', exemption_level: 10**7, t_medium: 365 * (50.0) , d_value: nil},
            { name: 'Pt-193m', exemption_level: 10**7, t_medium: 4.33 , d_value: nil},
            { name: 'Pt-195m', exemption_level: 10**6, t_medium: 4.02 , d_value: nil},
            { name: 'Pt-197', exemption_level: 10**6, t_medium: (1/24.0) * (18.3) , d_value: nil},
            { name: 'Pt-197m', exemption_level: 10**6, t_medium: (1/24.0) * (1.57) , d_value: nil},
            { name: 'Pt-199', exemption_level: 10**6, t_medium: (1/24.0) * (0.513) , d_value: nil},
            { name: 'Pt-200', exemption_level: 10**6, t_medium: (1/24.0) * (12.5) , d_value: nil},
        ]
      },
      { short: 'Au', long: 'Gold',         mass: 196.9665,  category:  2,
        radionuclides: [
            { name: 'Au-193', exemption_level: 10**7, t_medium: (1/24.0) * (17.6) , d_value: nil},
            { name: 'Au-194', exemption_level: 10**6, t_medium: 1.64 , d_value: nil},
            { name: 'Au-195', exemption_level: 10**7, t_medium: 183.0 , d_value: nil},
            { name: 'Au-198', exemption_level: 10**6, t_medium: 2.69 , d_value: nil},
            { name: 'Au-198m', exemption_level: 10**6, t_medium: 2.30 , d_value: nil},
            { name: 'Au-199', exemption_level: 10**6, t_medium: 3.14 , d_value: nil},
            { name: 'Au-200', exemption_level: 10**5, t_medium: (1/24.0) * (0.807) , d_value: nil},
            { name: 'Au-200m', exemption_level: 10**6, t_medium: (1/24.0) * (18.7) , d_value: nil},
            { name: 'Au-201', exemption_level: 10**6, t_medium: (1/24.0) * (0.440) , d_value: nil},
        ]
      },
      { short: 'Hg', long: 'Mercury',      mass: 200.59,    category:  2,
        radionuclides: [
            { name: 'Hg-193', exemption_level: 10**6, t_medium: (1/24.0) * (3.50) , d_value: nil},
            { name: 'Hg-193m', exemption_level: 10**6, t_medium: (1/24.0) * (11.1) , d_value: nil},
            { name: 'Hg-194', exemption_level: 10**6, t_medium: 365 * (2.60*(10**2)) , d_value: nil},
            { name: 'Hg-195', exemption_level: 10**6, t_medium: (1/24.0) * (9.90) , d_value: nil},
            { name: 'Hg-195m', exemption_level: 10**6, t_medium: 1.73 , d_value: nil},
            { name: 'Hg-197', exemption_level: 10**7, t_medium: 2.67 , d_value: nil},
            { name: 'Hg-197m', exemption_level: 10**6, t_medium: (1/24.0) * (23.8) , d_value: nil},
            { name: 'Hg-199m', exemption_level: 10**6, t_medium: (1/24.0) * (0.710) , d_value: nil},
            { name: 'Hg-203', exemption_level: 10**2, t_medium: 46.6 , d_value: nil},
        ]
      },   # 80
      { short: 'Tl', long: 'Thallium',     mass: 204.3833,  category:  3,
        radionuclides: [
            { name: 'Tl-194', exemption_level: 10**6, t_medium: (1/24.0) * (0.550) , d_value: nil},
            { name: 'Tl-194m', exemption_level: 10**6, t_medium: (1/24.0) * (0.546) , d_value: nil},
            { name: 'Tl-195', exemption_level: 10**6, t_medium: (1/24.0) * (1.16) , d_value: nil},
            { name: 'Tl-197', exemption_level: 10**6, t_medium: (1/24.0) * (2.84) , d_value: nil},
            { name: 'Tl-198', exemption_level: 10**6, t_medium: (1/24.0) * (5.30) , d_value: nil},
            { name: 'Tl-198m', exemption_level: 10**6, t_medium: (1/24.0) * (1.87) , d_value: nil},
            { name: 'Tl-199', exemption_level: 10**6, t_medium: (1/24.0) * (7.42) , d_value: nil},
            { name: 'Tl-200', exemption_level: 10**6, t_medium: 1.09 , d_value: nil},
            { name: 'Tl-201', exemption_level: 10**6, t_medium: 3.04 , d_value: nil},
            { name: 'Tl-202', exemption_level: 10**6, t_medium: 12.2 , d_value: nil},
            { name: 'Tl-204', exemption_level: 10**4, t_medium: 365 * (3.78) , d_value: nil},
        ]
      },
      { short: 'Pb', long: 'Lead',         mass: 204.3833,  category:  3,
        radionuclides: [
            { name: 'Pb-195m', exemption_level: 10**6, t_medium: (1/24.0) * (0.263) , d_value: nil},
            { name: 'Pb-198', exemption_level: 10**6, t_medium: (1/24.0) * (2.40) , d_value: nil},
            { name: 'Pb-199', exemption_level: 10**6, t_medium: (1/24.0) * (1.50) , d_value: nil},
            { name: 'Pb-200', exemption_level: 10**6, t_medium: (1/24.0) * (21.5) , d_value: nil},
            { name: 'Pb-201', exemption_level: 10**6, t_medium: (1/24.0) * (9.40) , d_value: nil},
            { name: 'Pb-202', exemption_level: 10**6, t_medium: 365 * (3.0*(10**5)) , d_value: nil},
            { name: 'Pb-202m', exemption_level: 10**6, t_medium: (1/24.0) * (3.62) , d_value: nil},
            { name: 'Pb-203', exemption_level: 10**6, t_medium: 2.17 , d_value: nil},
            { name: 'Pb-205', exemption_level: 10**7, t_medium: 365 * (1.43*(10**7)) , d_value: nil},
            { name: 'Pb-209', exemption_level: 10**6, t_medium: (1/24.0) * (3.25) , d_value: nil},
            { name: 'Pb-210', exemption_level: 10**4, t_medium: 365 * (22.3) , d_value: nil},
            { name: 'Pb-211', exemption_level: 10**6, t_medium: (1/24.0) * (0.601) , d_value: nil},
            { name: 'Pb-212', exemption_level: 10**5, t_medium: (1/24.0) * (10.6) , d_value: nil},
            { name: 'Pb-214', exemption_level: 10**6, t_medium: (1/24.0) * (0.447) , d_value: nil},
        ]
      },
      { short: 'Bi', long: 'Bismuth',      mass: 208.98037, category:  3,
        radionuclides: [
            { name: 'Bi-200', exemption_level: 10**6, t_medium: (1/24.0) * (0.606) , d_value: nil},
            { name: 'Bi-201', exemption_level: 10**6, t_medium: (1/24.0) * (1.80) , d_value: nil},
            { name: 'Bi-202', exemption_level: 10**6, t_medium: (1/24.0) * (1.67) , d_value: nil},
            { name: 'Bi-203', exemption_level: 10**6, t_medium: (1/24.0) * (11.8) , d_value: nil},
            { name: 'Bi-205', exemption_level: 10**6, t_medium: 15.3 , d_value: nil},
            { name: 'Bi-206', exemption_level: 10**5, t_medium: 6.24 , d_value: nil},
            { name: 'Bi-207', exemption_level: 10**6, t_medium: 365 * (38.0) , d_value: nil},
            { name: 'Bi-210', exemption_level: 10**6, t_medium: 5.01 , d_value: nil},
            { name: 'Bi-210m', exemption_level: 10**5, t_medium: 365 * (3.0*(10**6)) , d_value: nil},
            { name: 'Bi-212', exemption_level: 10**5, t_medium: (1/24.0) * (1.01) , d_value: nil},
            { name: 'Bi-213', exemption_level: 10**6, t_medium: (1/24.0) * (0.761) , d_value: nil},
            { name: 'Bi-214', exemption_level: 10**5, t_medium: (1/24.0) * (0.332) , d_value: nil},
        ]
      },
      { short: 'Po', long: 'Polonium',     mass: 208.9824,  category:  4,
        radionuclides: [
            { name: 'Po-203', exemption_level: 10**6, t_medium: (1/24.0) * (0.612) , d_value: nil},
            { name: 'Po-205', exemption_level: 10**6, t_medium: (1/24.0) * (1.80) , d_value: nil},
            { name: 'Po-206', exemption_level: 10**6, t_medium: 8.8 , d_value: nil},
            { name: 'Po-207', exemption_level: 10**6, t_medium: (1/24.0) * (5.83) , d_value: nil},
            { name: 'Po-208', exemption_level: 10**4, t_medium: 2.9 * 365 , d_value: nil},
            { name: 'Po-209', exemption_level: 10**4, t_medium: 102.11 * 365 , d_value: nil},
            { name: 'Po-210', exemption_level: 10**4, t_medium: 138.0 , d_value: nil},
        ]
      },
      { short: 'At', long: 'Astatine',     mass: 209.9871,  category:  6,
        radionuclides: [
            { name: 'At-207', exemption_level: 10**6, t_medium: (1/24.0) * (1.80) , d_value: nil},
            { name: 'At-211', exemption_level: 10**7, t_medium: (1/24.0) * (7.21) , d_value: nil},
        ]
      },
      { short: 'Rn', long: 'Radon',        mass: 222.0176,  category:  7,
        radionuclides: [
            { name: 'Rn-220', exemption_level: 10**7, t_medium: 55.6 / 60.0 / 60.0 / 24.0 , d_value: nil},
            { name: 'Rn-222', exemption_level: 10**8, t_medium: 3.82 , d_value: nil},
        ]
      },
      { short: 'Fr', long: 'Francium',     mass: 223.0197,  category:  0,
        radionuclides: [
            { name: 'Fr-222', exemption_level: 10**5, t_medium: (1/24.0) * (0.240) , d_value: nil},
            { name: 'Fr-223', exemption_level: 10**6, t_medium: (1/24.0) * (0.363) , d_value: nil},
        ]
      },
      { short: 'Ra', long: 'Radium',       mass: 226.0254,  category:  1,
        radionuclides: [
            { name: 'Ra-223', exemption_level: 10**5, t_medium: 11.4 , d_value: nil},
            { name: 'Ra-224', exemption_level: 10**5, t_medium: 3.66 , d_value: nil},
            { name: 'Ra-225', exemption_level: 10**5, t_medium: 14.8 , d_value: nil},
            { name: 'Ra-226', exemption_level: 10**4, t_medium: 365 * (1.60*(10**3)) , d_value: nil},
            { name: 'Ra-227', exemption_level: 10**6, t_medium: (1/24.0) * (0.703) , d_value: nil},
            { name: 'Ra-228', exemption_level: 10**5, t_medium: 365 * (5.75) , d_value: nil},
        ]
      },

      { short: 'Ac', long: 'Actinium',     mass: 227.0278,  category:  9,
        radionuclides: [
            { name: 'Ac-224', exemption_level: 10**6, t_medium: (1/24.0) * (2.90) , d_value: nil},
            { name: 'Ac-225', exemption_level: 10**4, t_medium: 10.0 , d_value: nil},
            { name: 'Ac-226', exemption_level: 10**5, t_medium: 1.21 , d_value: nil},
            { name: 'Ac-227', exemption_level: 10**3, t_medium: 365 * (21.8) , d_value: nil},
            { name: 'Ac-228', exemption_level: 10**6, t_medium: (1/24.0) * (6.13) , d_value: nil},
        ]
      },
      { short: 'Th', long: 'Thorium',      mass: 232.0381,  category:  9,
        radionuclides: [
            { name: 'Th-226', exemption_level: 10**7, t_medium: (1/24.0) * (0.515) , d_value: nil},
            { name: 'Th-227', exemption_level: 10**4, t_medium: 18.7 , d_value: nil},
            { name: 'Th-228', exemption_level: 10**4, t_medium: 365 * (1.91) , d_value: nil},
            { name: 'Th-229', exemption_level: 10**3, t_medium: 365 * (7.34*(10**3)) , d_value: nil},
            { name: 'Th-230', exemption_level: 10**4, t_medium: 365 * (7.70*(10**4)) , d_value: nil},
            { name: 'Th-231', exemption_level: 10**7, t_medium: 1.06 , d_value: nil},
            { name: 'Th-232', exemption_level: 10**4, t_medium: 365 * (1.40*(10**10)) , d_value: nil},
            { name: 'Th-234', exemption_level: 10**5, t_medium: 24.1 , d_value: nil},
        ]
      },   # 90
      { short: 'Pa', long: 'Protactinium', mass: 231.03588, category:  9,
        radionuclides: [
            { name: 'Pa-227', exemption_level: 10**6, t_medium: (1/24.0) * (0.638) , d_value: nil},
            { name: 'Pa-228', exemption_level: 10**6, t_medium: (1/24.0) * (22.0) , d_value: nil},
            { name: 'Pa-230', exemption_level: 10**6, t_medium: 17.4 , d_value: nil},
            { name: 'Pa-231', exemption_level: 10**3, t_medium: 365 * (3.27*(10**4)) , d_value: nil},
            { name: 'Pa-232', exemption_level: 10**6, t_medium: 1.31 , d_value: nil},
            { name: 'Pa-233', exemption_level: 10**7, t_medium: 27.0 , d_value: nil},
            { name: 'Pa-234', exemption_level: 10**6, t_medium: (1/24.0) * (6.70) , d_value: nil},
        ]
      },
      { short: 'U',  long: 'Uranium',      mass: 238.0289,  category:  9,
        radionuclides: [
            { name: 'U-230', exemption_level: 10**5, t_medium: 20.8 , d_value: nil},
            { name: 'U-231', exemption_level: 10**7, t_medium: 4.20 , d_value: nil},
            { name: 'U-232', exemption_level: 10**3, t_medium: 365 * (72.0) , d_value: nil},
            { name: 'U-233', exemption_level: 10**4, t_medium: 365 * (1.58*(10**5)) , d_value: nil},
            { name: 'U-234', exemption_level: 10**4, t_medium: 365 * (2.44*(10**5)) , d_value: nil},
            { name: 'U-235', exemption_level: 10**4, t_medium: 365 * (7.04*(10**8)) , d_value: nil},
            { name: 'U-236', exemption_level: 10**4, t_medium: 365 * (2.34*(10**7)) , d_value: nil},
            { name: 'U-237', exemption_level: 10**6, t_medium: 6.75 , d_value: nil},
            { name: 'U-238', exemption_level: 10**4, t_medium: 365 * (4.47*(10**9)) , d_value: nil},
            { name: 'U-239', exemption_level: 10**6, t_medium: (1/24.0) * (0.392) , d_value: nil},
            { name: 'U-240', exemption_level: 10**7, t_medium: (1/24.0) * (14.1) , d_value: nil},
            { name: 'U-240', exemption_level: 10**6, t_medium: (1/24.0) * (14.1) , d_value: nil},
        ]
      },
      { short: 'Np', long: 'Neptunium',    mass: 237.0482,  category:  9,
        radionuclides: [
            { name: 'Np-232', exemption_level: 10**6, t_medium: (1/24.0) * (0.245) , d_value: nil},
            { name: 'Np-233', exemption_level: 10**7, t_medium: (1/24.0) * (0.603) , d_value: nil},
            { name: 'Np-234', exemption_level: 10**6, t_medium: 4.40 , d_value: nil},
            { name: 'Np-235', exemption_level: 10**7, t_medium: 365 * (1.08) , d_value: nil},
            { name: 'Np-236', exemption_level: 10**5, t_medium: 365 * (1.15*(10**5)) , d_value: nil},
            { name: 'Np-236m', exemption_level: 10**7, t_medium: (1/24.0) * (22.5) , d_value: nil},
            { name: 'Np-237', exemption_level: 10**3, t_medium: 365 * (2.14*(10**6)) , d_value: nil},
            { name: 'Np-238', exemption_level: 10**6, t_medium: 2.12 , d_value: nil},
            { name: 'Np-239', exemption_level: 10**7, t_medium: 2.36 , d_value: nil},
            { name: 'Np-240', exemption_level: 10**6, t_medium: (1/24.0) * (1.08) , d_value: nil},
        ]
      },
      { short: 'Pu', long: 'Plutonium',    mass: 244.0642,  category:  9,
        radionuclides: [
            { name: 'Pu-234', exemption_level: 10**7, t_medium: (1/24.0) * (8.80) , d_value: nil},
            { name: 'Pu-235', exemption_level: 10**7, t_medium: (1/24.0) * (0.422) , d_value: nil},
            { name: 'Pu-236', exemption_level: 10**4, t_medium: 365 * (2.85) , d_value: nil},
            { name: 'Pu-237', exemption_level: 10**7, t_medium: 45.3 , d_value: nil},
            { name: 'Pu-238', exemption_level: 10**4, t_medium: 365 * (87.7) , d_value: nil},
            { name: 'Pu-239', exemption_level: 10**4, t_medium: 365 * (2.41*(10**4)) , d_value: nil},
            { name: 'Pu-240', exemption_level: 10**3, t_medium: 365 * (6.54*(10**3)) , d_value: nil},
            { name: 'Pu-241', exemption_level: 10**5, t_medium: 365 * (14.4) , d_value: nil},
            { name: 'Pu-242', exemption_level: 10**4, t_medium: 365 * (3.76*(10**5)) , d_value: nil},
            { name: 'Pu-243', exemption_level: 10**7, t_medium: (1/24.0) * (4.95) , d_value: nil},
            { name: 'Pu-244', exemption_level: 10**4, t_medium: 365 * (8.26*(10**7)) , d_value: nil},
            { name: 'Pu-245', exemption_level: 10**6, t_medium: (1/24.0) * (10.5) , d_value: nil},
            { name: 'Pu-246', exemption_level: 10**6, t_medium: 10.9 , d_value: nil},
        ]
      },
      { short: 'Am', long: 'Americium',    mass: 243.0614,  category:  9,
        radionuclides: [
            { name: 'Am-237', exemption_level: 10**6, t_medium: (1/24.0) * (1.22) , d_value: nil},
            { name: 'Am-238', exemption_level: 10**6, t_medium: (1/24.0) * (1.63) , d_value: nil},
            { name: 'Am-239', exemption_level: 10**6, t_medium: (1/24.0) * (11.9) , d_value: nil},
            { name: 'Am-240', exemption_level: 10**6, t_medium: 2.12 , d_value: nil},
            { name: 'Am-241', exemption_level: 10**4, t_medium: 365 * (4.32*(10**2)) , d_value: nil},
            { name: 'Am-242', exemption_level: 10**6, t_medium: (1/24.0) * (16.0) , d_value: nil},
            { name: 'Am-242m', exemption_level: 10**4, t_medium: 365 * (1.52*(10**2)) , d_value: nil},
            { name: 'Am-243', exemption_level: 10**3, t_medium: 365 * (7.38*(10**3)) , d_value: nil},
            { name: 'Am-244', exemption_level: 10**6, t_medium: (1/24.0) * (10.1) , d_value: nil},
            { name: 'Am-244m', exemption_level: 10**7, t_medium: (1/24.0) * (0.433) , d_value: nil},
            { name: 'Am-245', exemption_level: 10**6, t_medium: (1/24.0) * (2.05) , d_value: nil},
            { name: 'Am-246', exemption_level: 10**5, t_medium: (1/24.0) * (0.650) , d_value: nil},
            { name: 'Am-246m', exemption_level: 10**6, t_medium: (1/24.0) * (0.417) , d_value: nil},
        ]
      },
      { short: 'Cm', long: 'Curium',       mass: 247.0703,  category:  9,
        radionuclides: [
            { name: 'Cm-238', exemption_level: 10**7, t_medium: (1/24.0) * (2.40) , d_value: nil},
            { name: 'Cm-240', exemption_level: 10**5, t_medium: 27.0 , d_value: nil},
            { name: 'Cm-241', exemption_level: 10**6, t_medium: 32.8 , d_value: nil},
            { name: 'Cm-242', exemption_level: 10**5, t_medium: 163.0 , d_value: nil},
            { name: 'Cm-243', exemption_level: 10**4, t_medium: 365 * (28.5) , d_value: nil},
            { name: 'Cm-244', exemption_level: 10**4, t_medium: 365 * (18.1) , d_value: nil},
            { name: 'Cm-245', exemption_level: 10**3, t_medium: 365 * (8.50*(10**3)) , d_value: nil},
            { name: 'Cm-246', exemption_level: 10**3, t_medium: 365 * (4.73*(10**3)) , d_value: nil},
            { name: 'Cm-247', exemption_level: 10**4, t_medium: 365 * (1.56*(10**7)) , d_value: nil},
            { name: 'Cm-248', exemption_level: 10**3, t_medium: 365 * (3.39*(10**5)) , d_value: nil},
            { name: 'Cm-249', exemption_level: 10**6, t_medium: (1/24.0) * (1.07) , d_value: nil},
            { name: 'Cm-250', exemption_level: 10**3, t_medium: 365 * (6.90*(10**3)) , d_value: nil},
        ]
      },
      { short: 'Bk', long: 'Berkelium',    mass: 247.0703,  category:  9,
        radionuclides: [
            { name: 'Bk-245', exemption_level: 10**6, t_medium: 4.94 , d_value: nil},
            { name: 'Bk-246', exemption_level: 10**6, t_medium: 1.83 , d_value: nil},
            { name: 'Bk-247', exemption_level: 10**4, t_medium: 365 * (1.38*(10**3)) , d_value: nil},
            { name: 'Bk-249', exemption_level: 10**6, t_medium: 320.0 , d_value: nil},
            { name: 'Bk-250', exemption_level: 10**6, t_medium: (1/24.0) * (3.22) , d_value: nil},
        ]
      },
      { short: 'Cf', long: 'Californium',  mass: 251.0796,  category:  9,
        radionuclides: [
            { name: 'Cf-244', exemption_level: 10**7, t_medium: (1/24.0) * (0.323) , d_value: nil},
            { name: 'Cf-246', exemption_level: 10**6, t_medium: 1.49 , d_value: nil},
            { name: 'Cf-248', exemption_level: 10**4, t_medium: 334.0 , d_value: nil},
            { name: 'Cf-249', exemption_level: 10**3, t_medium: 365 * (3.50*(10**2)) , d_value: nil},
            { name: 'Cf-250', exemption_level: 10**4, t_medium: 365 * (13.1) , d_value: nil},
            { name: 'Cf-251', exemption_level: 10**3, t_medium: 365 * (8.98*(10**2)) , d_value: nil},
            { name: 'Cf-252', exemption_level: 10**4, t_medium: 365 * (2.64) , d_value: nil},
            { name: 'Cf-253', exemption_level: 10**5, t_medium: 17.8 , d_value: nil},
            { name: 'Cf-254', exemption_level: 10**3, t_medium: 60.5 , d_value: nil},
        ]
      },
      { short: 'Es', long: 'Einsteinium',  mass: 254,       category:  9,
        radionuclides: [
            { name: 'Es-250', exemption_level: 10**6, t_medium: (1/24.0) * (2.10) , d_value: nil},
            { name: 'Es-251', exemption_level: 10**7, t_medium: 1.38 , d_value: nil},
            { name: 'Es-253', exemption_level: 10**5, t_medium: 20.5 , d_value: nil},
            { name: 'Es-254', exemption_level: 10**4, t_medium: 276.0 , d_value: nil},
            { name: 'Es-254m', exemption_level: 10**6, t_medium: 1.64 , d_value: nil},
        ]
      },
      { short: 'Fm', long: 'Fermium',      mass: 257.0951,  category:  9,
        radionuclides: [
            { name: 'Fm-252', exemption_level: 10**6, t_medium: (1/24.0) * (22.7) , d_value: nil},
            { name: 'Fm-253', exemption_level: 10**6, t_medium: 3.0 , d_value: nil},
            { name: 'Fm-254', exemption_level: 10**7, t_medium: (1/24.0) * (3.24) , d_value: nil},
            { name: 'Fm-255', exemption_level: 10**6, t_medium: (1/24.0) * (20.1) , d_value: nil},
            { name: 'Fm-257', exemption_level: 10**5, t_medium: 101.0 , d_value: nil},
        ]
      },   # 100
      { short: 'Md', long: 'Mendelevium',  mass: 258.1,     category:  9,
        radionuclides: [
            { name: 'Md-257', exemption_level: 10**7, t_medium: (1/24.0) * (5.20) , d_value: nil},
            { name: 'Md-258', exemption_level: 10**5, t_medium: 55.0 , d_value: nil},
        ]
      },
      { short: 'No', long: 'Nobelium',     mass: 259.1009,  category:  9,
        radionuclides: []
      },
      { short: 'Lr', long: 'Lawrencium',   mass: 262,       category:  9,
        radionuclides: []
      },

      { short: 'Rf', long: 'Rutherfordium', mass: 261, category: 2,
        radionuclides: []
      },
      { short: 'Db', long: 'Dubnium',      mass: 262,       category:  2,
        radionuclides: []
      },
      { short: 'Sg', long: 'Seaborgium',   mass: 266,       category:  2,
        radionuclides: []
      },
      { short: 'Bh', long: 'Bohrium',      mass: 264,       category:  2,
        radionuclides: []
      },
      { short: 'Hs', long: 'Hassium',      mass: 269,       category:  2,
        radionuclides: []
      },
      { short: 'Mt', long: 'Meitnerium',   mass: 268,       category:  2,
        radionuclides: []
      },
      { short: 'Ds', long: 'Darmstadium',  mass: 269,       category:  2,
        radionuclides: []
      },   # 110
      { short: 'Rg', long: 'Roentgenium',  mass: 272,       category:  2,
        radionuclides: []
      },
      { short: 'Cn', long: 'Copernicium',  mass: 277,       category:  2,
        radionuclides: []
      },
      { short: 'Uut', long: 'Ununtrium', mass: 286, category: 3,
        radionuclides: []
      },
      { short: 'Fl', long: 'Flerovium', mass: 289, category: 3,
        radionuclides: []
      },
      { short: 'Uup', long: 'Ununpentium', mass: 288, category: 3,
        radionuclides: []
      },
      { short: 'Lv', long: 'Livermorium', mass: 293, category: 3,
        radionuclides: []
      },
      { short: 'Uus', long: 'Ununseptium',  mass: 294,       category:  6,
        radionuclides: []
      },
      { short: 'Uuo', long: 'Ununoctium',   mass: 294,       category:  7,
        radionuclides: []
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
