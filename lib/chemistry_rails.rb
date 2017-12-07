require 'cas_number_validator'
module ChemistryRails
  ELEMENT_CATEGORIES = ['Alkali Metal', 'Alkaline Earth', 'Transition Metal', 'Basic Metal', 'Semimetal', 'Nonmetal', 'Halogen', 'Noble gas', 'Lanthanide', 'Actinide'].freeze

  ELEMENTS = [
      nil,
      { short: 'H', long: 'Hydrogen', mass: 1.0079, category: 5,
        radionuclides: [
            { name: 'H-3', exemption_level: 10**9, t_medium: years(12.3) }
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
            { name: 'Be-7', exemption_level: 10**7, t_medium: 53.3 },
            { name: 'Be-10', exemption_level: 10**6, t_medium: years(1.6*(10**6)) }
        ]
      },
      { short: 'B',  long: 'Boron',        mass: 10.811,    category: 4,
        radionuclides: []
      },
      { short: 'C',  long: 'Carbon',       mass: 12.011,    category: 5,
        radionuclides: [
            { name: 'C-11', exemption_level: 10**6, t_medium: hours(0.34) },
            { name: 'C-14', exemption_level: 10**7, t_medium: years(5.73*(10**3)) }
        ]
      },
      { short: 'N',  long: 'Nitrogen',     mass: 14.00674,  category: 5,
        radionuclides: [
            { name: 'N-13', exemption_level: 10**9, t_medium: nil },
        ]
      },
      { short: 'O',  long: 'Oxygen',       mass: 15.9994,   category: 5,
        radionuclides: [
            { name: 'O-15', exemption_level: 10**9, t_medium: nil },
        ]
      },
      { short: 'F',  long: 'Fluorine',     mass: 18.998403, category: 6,
        radionuclides: [
            { name: 'F-18', exemption_level: 10**6, t_medium: hours(1.83) }
        ]
      },
      { short: 'Ne', long: 'Neon',         mass: 20.1797,   category: 7,
        radionuclides: [
            { name: 'Ne-19', exemption_level: 10**9, t_medium: nil },
        ]
      },    # 10
      { short: 'Na', long: 'Sodium',       mass: 22.989768, category: 0,
        radionuclides: [
            { name: 'Na-22', exemption_level: 10**6, t_medium: years(2.60) },
            { name: 'Na-24', exemption_level: 10**5, t_medium: hours(15) }
        ]
      },
      { short: 'Mg', long: 'Magnesium',    mass: 24.305,    category: 1,
        radionuclides: [
            { name: 'Mg-28', exemption_level: 10**5, t_medium: hours(20.9) }
        ]
      },
      { short: 'Al', long: 'Aluminium',    mass: 26.981539, category: 3,
        radionuclides: [
            { name: 'Al-26', exemption_level: 10**5, t_medium: years(7.16*(10**5)) }
        ]
      },
      { short: 'Si', long: 'Silicon',      mass: 28.0855,   category: 4,
        radionuclides: [
            { name: 'Si-31', exemption_level: 10**6, t_medium: hours(2.62) },
            { name: 'Si-32', exemption_level: 10**6, t_medium: years(4.50*(10**2)) }
        ]
      },
      { short: 'P',  long: 'Phosphorus',   mass: 30.973762, category: 5,
        radionuclides: [
            { name: 'P-32', exemption_level: 10**5, t_medium: 14.3 },
            { name: 'P-33', exemption_level: 10**8, t_medium: 25.4 }
        ]
      },
      { short: 'S',  long: 'Sulfur',       mass: 32.066,    category: 5,
        radionuclides: [
            { name: 'S-35', exemption_level: 10**8, t_medium: 87.4 }
        ]
      },
      { short: 'Cl', long: 'Chlorine',     mass: 35.4527,   category: 6,
        radionuclides: [
            { name: 'Cl-36', exemption_level: 10**6, t_medium: years(3.01*(10**5)) },
            { name: 'Cl-38', exemption_level: 10**5, t_medium: hours(0.620) },
            { name: 'Cl-39', exemption_level: 10**5, t_medium: hours(0.927) }
        ]
      },
      { short: 'Ar', long: 'Argon',        mass: 39.948,    category: 7,
        radionuclides: [
            { name: 'Ar-37', exemption_level: 10**8, t_medium: nil },
            { name: 'Ar-39', exemption_level: 10**4, t_medium: nil },
            { name: 'Ar-41', exemption_level: 10**9, t_medium: nil }
        ]
      },
      { short: 'K',  long: 'Potassium',    mass: 39.0983,   category: 0,
        radionuclides: [
            { name: 'K-40', exemption_level: 10**6, t_medium: years(1.28*(10**9)) },
            { name: 'K-42', exemption_level: 10**6, t_medium: hours(12.4) },
            { name: 'K-43', exemption_level: 10**6, t_medium: hours(22.6) },
            { name: 'K-44', exemption_level: 10**5, t_medium: hours(0.369) },
            { name: 'K-45', exemption_level: 10**5, t_medium: hours(0.333) },
        ]
      },
      { short: 'Ca', long: 'Calcium',      mass: 40.078,    category: 1,
        radionuclides: [
            { name: 'Ca-41', exemption_level: 10**7, t_medium: years(1.40*(10**5)) },
            { name: 'Ca-45', exemption_level: 10**7, t_medium: 136 },
            { name: 'Ca-47', exemption_level: 10**6, t_medium: 4.53 },
        ]
      },    # 20
      { short: 'Sc', long: 'Scandium',     mass: 44.95591,  category: 2,
        radionuclides: [
            { name: 'Sc-43', exemption_level: 10**6, t_medium: hours(3.89) },
            { name: 'Sc-44', exemption_level: 10**5, t_medium: hours(3.93) },
            { name: 'Sc-44m', exemption_level: nil, t_medium: 2.44 },
            { name: 'Sc-45', exemption_level: 10**7, t_medium: nil },
            { name: 'Sc-46', exemption_level: 10**6, t_medium: 83.8 },
            { name: 'Sc-47', exemption_level: 10**6, t_medium: 3.35 },
            { name: 'Sc-48', exemption_level: 10**5, t_medium: 1.82 },
            { name: 'Sc-49', exemption_level: 10**5, t_medium: hours(0.956) },
        ]
      },
      { short: 'Ti', long: 'Titanium',     mass: 47.88,     category: 2,
        radionuclides: [
            { name: 'Ti-44', exemption_level: 10**5, t_medium: years(47.3) },
            { name: 'Ti-45', exemption_level: 10**6, t_medium: hours(3.08) },
        ]
      },
      { short: 'V',  long: 'Vanadium',     mass: 50.9415,   category: 2,
        radionuclides: [
            { name: 'V-47', exemption_level: 10**5, t_medium: hours(0.543) },
            { name: 'V-48', exemption_level: 10**5, t_medium: 16.2 },
            { name: 'V-49', exemption_level: 10**7, t_medium: 330 },
        ]
      },
      { short: 'Cr', long: 'Chromium',     mass: 51.9961,   category: 2,
        radionuclides: [
            { name: 'Cr-48', exemption_level: 10**6, t_medium: hours(23) },
            { name: 'Cr-49', exemption_level: 10**6, t_medium: hours(0.702) },
            { name: 'Cr-51', exemption_level: 10**7, t_medium: 27.7 },
        ]
      },
      { short: 'Mn', long: 'Manganese',    mass: 54.938,    category: 2,
        radionuclides: [
            { name: 'Mn-51', exemption_level: 10**5, t_medium: hours(0.770) },
            { name: 'Mn-52', exemption_level: 10**5, t_medium: 5.59 },
            { name: 'Mn-52m', exemption_level: 10**5, t_medium: hours(0.352) },
            { name: 'Mn-53', exemption_level: 10**9, t_medium: years(3.70*(10**6)) },
            { name: 'Mn-54', exemption_level: 10**6, t_medium: 312 },
            { name: 'Mn-56', exemption_level: 10**5, t_medium: hours(2.58) },
        ]
      },
      { short: 'Fe', long: 'Iron',         mass: 54.847,    category: 2,
        radionuclides: [
            { name: 'Fe-52', exemption_level: 10**6, t_medium: hours(8.28) },
            { name: 'Fe-55', exemption_level: 10**6, t_medium: years(2.70) },
            { name: 'Fe-59', exemption_level: 10**6, t_medium: 44.5 },
            { name: 'Fe-60', exemption_level: 10**5, t_medium: years(10**5) },
        ]
      },
      { short: 'Co', long: 'Cobalt',       mass: 58.9332,   category: 2,
        radionuclides: [
            { name: 'Co-55', exemption_level: 10**6, t_medium: hours(17.5) },
            { name: 'Co-56', exemption_level: 10**5, t_medium: 78.7 },
            { name: 'Co-57', exemption_level: 10**6, t_medium: 271 },
            { name: 'Co-58', exemption_level: 10**6, t_medium: 70.8 },
            { name: 'Co-58m', exemption_level: 10**7, t_medium: hours(9.15) },
            { name: 'Co-60', exemption_level: 10**5, t_medium: years(5.27) },
            { name: 'Co-60m', exemption_level: 10**6, t_medium: hours(0.174) },
            { name: 'Co-61', exemption_level: 10**6, t_medium: hours(1.65) },
            { name: 'Co-62m', exemption_level: 10**5, t_medium: hours(0.232) },
        ]
      },
      { short: 'Ni', long: 'Nickel',       mass: 58.6934,   category: 2,
        radionuclides: [
            { name: 'Ni-56', exemption_level: 10**6, t_medium: 6.10 },
            { name: 'Ni-57', exemption_level: 10**6, t_medium: 1.50 },
            { name: 'Ni-59', exemption_level: 10**8, t_medium: years(7.50*(10**4)) },
            { name: 'Ni-63', exemption_level: 10**8, t_medium: years(96) },
            { name: 'Ni-65', exemption_level: 10**6, t_medium: hours(2.52) },
            { name: 'Ni-66', exemption_level: 10**7, t_medium: 2.27 },
        ]
      },
      { short: 'Cu', long: 'Copper',       mass: 63.546,    category: 2,
        radionuclides: [
            { name: 'Cu-60', exemption_level: 10**5, t_medium: hours(0.387) },
            { name: 'Cu-61', exemption_level: 10**6, t_medium: hours(3.41) },
            { name: 'Cu-64', exemption_level: 10**6, t_medium: hours(12.7) },
            { name: 'Cu-67', exemption_level: 10**6, t_medium: 2.58 },
        ]
      },
      { short: 'Zn', long: 'Zinc',         mass: 65.39,     category: 2,
        radionuclides: [
            { name: 'Zn-62', exemption_level: 10**6, t_medium: hours(9.26) },
            { name: 'Zn-63', exemption_level: 10**5, t_medium: hours(0.635) },
            { name: 'Zn-65', exemption_level: 10**6, t_medium: 244 },
            { name: 'Zn-69', exemption_level: 10**6, t_medium: hours(0.950) },
            { name: 'Zn-69m', exemption_level: 10**6, t_medium: hours(13.8) },
            { name: 'Zn-71m', exemption_level: 10**6, t_medium: hours(3.92) },
            { name: 'Zn-72', exemption_level: 10**6, t_medium: 1.94 },
        ]
      },    # 30
      { short: 'Ga', long: 'Gallium',      mass: 69.732,    category: 3,
        radionuclides: [
            { name: 'Ga-65', exemption_level: 10**5, t_medium: hours(0.253) },
            { name: 'Ga-66', exemption_level: 10**5, t_medium: hours(9.40) },
            { name: 'Ga-67', exemption_level: 10**6, t_medium: 3.26 },
            { name: 'Ga-68', exemption_level: 10**5, t_medium: hours(1.13) },
            { name: 'Ga-70', exemption_level: 10**6, t_medium: hours(0.353) },
            { name: 'Ga-72', exemption_level: 10**5, t_medium: hours(14.1) },
            { name: 'Ga-73', exemption_level: 10**6, t_medium: hours(4.91) },
        ]
      },
      { short: 'Ge', long: 'Germanium',    mass: 72.64,     category: 4,
        radionuclides: [
            { name: 'Ge-66', exemption_level: 10**6, t_medium: hours(2.27) },
            { name: 'Ge-67', exemption_level: 10**5, t_medium: hours(0.312) },
            { name: 'Ge-68', exemption_level: 10**5, t_medium: 288 },
            { name: 'Ge-69', exemption_level: 10**6, t_medium: 1.63 },
            { name: 'Ge-71', exemption_level: 10**8, t_medium: 11.8 },
            { name: 'Ge-75', exemption_level: 10**6, t_medium: hours(1.38) },
            { name: 'Ge-77', exemption_level: 10**5, t_medium: hours(11.3) },
            { name: 'Ge-78', exemption_level: 10**6, t_medium: hours(1.45) },
        ]
      },
      { short: 'As', long: 'Arsenic',      mass: 74.92159,  category: 4,
        radionuclides: [
            { name: 'As-69', exemption_level: 10**5, t_medium: hours(0.253) },
            { name: 'As-70', exemption_level: 10**5, t_medium: hours(0.876) },
            { name: 'As-71', exemption_level: 10**6, t_medium: 2.70 },
            { name: 'As-72', exemption_level: 10**5, t_medium: 1.08 },
            { name: 'As-73', exemption_level: 10**7, t_medium: 80.3 },
            { name: 'As-74', exemption_level: 10**6, t_medium: 17.8 },
            { name: 'As-76', exemption_level: 10**5, t_medium: 1.10 },
            { name: 'As-77', exemption_level: 10**6, t_medium: 1.62 },
            { name: 'As-78', exemption_level: 10**5, t_medium: hours(1.51) },
        ]
      },
      { short: 'Se', long: 'Selenium',     mass: 78.96,     category: 5,
        radionuclides: [
            { name: 'Se-70', exemption_level: 10**6, t_medium: hours(0.683) },
            { name: 'Se-73', exemption_level: 10**6, t_medium: hours(7.15) },
            { name: 'Se-73m', exemption_level: 10**6, t_medium: hours(0.650) },
            { name: 'Se-75', exemption_level: 10**6, t_medium: 120 },
            { name: 'Se-79', exemption_level: 10**7, t_medium: years(6.50*(10**4)) },
            { name: 'Se-81', exemption_level: 10**6, t_medium: hours(0.308) },
            { name: 'Se-81m', exemption_level: 10**7, t_medium: hours(0.954) },
            { name: 'Se-83', exemption_level: 10**5, t_medium: hours(0.375) },
        ]
      },
      { short: 'Br', long: 'Bromine',      mass: 79.904,    category: 6,
        radionuclides: [
            { name: 'Br-74', exemption_level: 10**5, t_medium: hours(0.422) },
            { name: 'Br-74m', exemption_level: 10**5, t_medium: hours(0.691) },
            { name: 'Br-75', exemption_level: 10**6, t_medium: hours(1.63) },
            { name: 'Br-76', exemption_level: 10**5, t_medium: hours(16.2) },
            { name: 'Br-77', exemption_level: 10**6, t_medium: 2.33 },
            { name: 'Br-80', exemption_level: 10**5, t_medium: hours(0.290) },
            { name: 'Br-80m', exemption_level: 10**7, t_medium: hours(4.42) },
            { name: 'Br-82', exemption_level: 10**6, t_medium: 1.47 },
            { name: 'Br-83', exemption_level: 10**6, t_medium: hours(2.39) },
            { name: 'Br-84', exemption_level: 10**5, t_medium: hours(0.530) },
        ]
      },
      { short: 'Kr', long: 'Krypton',      mass: 83.80,     category: 7,
        radionuclides: [
            { name: 'Kr-74', exemption_level: 10**9, t_medium: nil },
            { name: 'Kr-76', exemption_level: 10**9, t_medium: nil },
            { name: 'Kr-77', exemption_level: 10**9, t_medium: nil },
            { name: 'Kr-79', exemption_level: 10**5, t_medium: nil },
            { name: 'Kr-81', exemption_level: 10**7, t_medium: nil },
            { name: 'Kr-81m', exemption_level: 10**10, t_medium: nil },
            { name: 'Kr-83m', exemption_level: 10**12, t_medium: nil },
            { name: 'Kr-85', exemption_level: 10**4, t_medium: nil },
            { name: 'Kr-85m', exemption_level: 10**10, t_medium: nil },
            { name: 'Kr-87', exemption_level: 10**9, t_medium: nil },
            { name: 'Kr-88', exemption_level: 10**9, t_medium: nil },
        ]
      },
      { short: 'Rb', long: 'Rubidium',     mass: 85.4678,   category: 0,
        radionuclides: [
            { name: 'Rb-79', exemption_level: 10**5, t_medium: hours(0.382) },
            { name: 'Rb-81', exemption_level: 10**6, t_medium: hours(4.58) },
            { name: 'Rb-81m', exemption_level: 10**7, t_medium: hours(0.533) },
            { name: 'Rb-82m', exemption_level: 10**6, t_medium: hours(6.20) },
            { name: 'Rb-83', exemption_level: 10**6, t_medium: 86.2 },
            { name: 'Rb-84', exemption_level: 10**6, t_medium: 32.8 },
            { name: 'Rb-86', exemption_level: 10**5, t_medium: 18.6 },
            { name: 'Rb-87', exemption_level: 10**7, t_medium: years(4.70*(10**10)) },
            { name: 'Rb-88', exemption_level: 10**5, t_medium: hours(0.297) },
            { name: 'Rb-89', exemption_level: 10**5, t_medium: hours(0.253) },
        ]
      },
      { short: 'Sr', long: 'Strontium',    mass: 87.62,     category: 1,
        radionuclides: [
            { name: 'Sr-80', exemption_level: 10**7, t_medium: hours(1.67) },
            { name: 'Sr-81', exemption_level: 10**5, t_medium: hours(0.425) },
            { name: 'Sr-82', exemption_level: 10**5, t_medium: 25 },
            { name: 'Sr-83', exemption_level: 10**6, t_medium: 1.35 },
            { name: 'Sr-85', exemption_level: 10**6, t_medium: 64.8 },
            { name: 'Sr-85m', exemption_level: 10**7, t_medium: hours(1.16) },
            { name: 'Sr-87m', exemption_level: 10**6, t_medium: hours(2.80) },
            { name: 'Sr-89', exemption_level: 10**6, t_medium: 50.5 },
            { name: 'Sr-90', exemption_level: 10**4, t_medium: years(29.1) },
            { name: 'Sr-91', exemption_level: 10**5, t_medium: hours(9.50) },
            { name: 'Sr-92', exemption_level: 10**6, t_medium: hours(2.71) },
        ]
      },
      { short: 'Y',  long: 'Yttrium',      mass: 88.90585,  category: 2,
        radionuclides: [
            { name: 'Y-86', exemption_level: 10**5, t_medium: hours(14.7) },
            { name: 'Y-86m', exemption_level: 10**7, t_medium: hours(0.800) },
            { name: 'Y-87', exemption_level: 10**6, t_medium: 3.35 },
            { name: 'Y-88', exemption_level: 10**6, t_medium: 107 },
            { name: 'Y-90', exemption_level: 10**5, t_medium: 2.67 },
            { name: 'Y-90m', exemption_level: 10**6, t_medium: hours(3.19) },
            { name: 'Y-91', exemption_level: 10**6, t_medium: 58.5 },
            { name: 'Y-91m', exemption_level: 10**6, t_medium: hours(0.828) },
            { name: 'Y-92', exemption_level: 10**5, t_medium: hours(3.54) },
            { name: 'Y-93', exemption_level: 10**5, t_medium: hours(10.1) },
            { name: 'Y-94', exemption_level: 10**5, t_medium: hours(0.318) },
            { name: 'Y-95', exemption_level: 10**5, t_medium: hours(0.178) },
        ]
      },
      { short: 'Zr', long: 'Zirconium',    mass: 91.224,    category: 2,
        radionuclides: [
            { name: 'Zr-86', exemption_level: 10**7, t_medium: hours(16.5) },
            { name: 'Zr-88', exemption_level: 10**6, t_medium: 83.4 },
            { name: 'Zr-89', exemption_level: 10**6, t_medium: 3.27 },
            { name: 'Zr-93', exemption_level: 10**7, t_medium: years(1.53*(10**6)) },
            { name: 'Zr-95', exemption_level: 10**6, t_medium: 64 },
            { name: 'Zr-97', exemption_level: 10**5, t_medium: hours(16.9) },
        ]
      },    # 40
      { short: 'Nb', long: 'Niobium',      mass: 92.90638,  category: 2,
        radionuclides: [
            { name: 'Nb-88', exemption_level: 10**5, t_medium: hours(0.238) },
            { name: 'Nb-89', exemption_level: 10**5, t_medium: hours(2.03) },
            { name: 'Nb-89m', exemption_level: 10**5, t_medium: hours(1.10) },
            { name: 'Nb-90', exemption_level: 10**5, t_medium: hours(14.6) },
            { name: 'Nb-93m', exemption_level: 10**7, t_medium: years(13.6) },
            { name: 'Nb-94', exemption_level: 10**6, t_medium: years(2.03*(10**4)) },
            { name: 'Nb-95', exemption_level: 10**6, t_medium: 35.1 },
            { name: 'Nb-95m', exemption_level: 10**7, t_medium: 3.61 },
            { name: 'Nb-96', exemption_level: 10**5, t_medium: hours(23.3) },
            { name: 'Nb-97', exemption_level: 10**6, t_medium: hours(1.20) },
            { name: 'Nb-98', exemption_level: 10**5, t_medium: hours(0.858) },
        ]
      },
      { short: 'Mo', long: 'Molybdenum',   mass: 95.94,     category: 2,
        radionuclides: [
            { name: 'Mo-90', exemption_level: 10**6, t_medium: hours(5.67) },
            { name: 'Mo-93', exemption_level: 10**8, t_medium: years(3.50*(10**3)) },
            { name: 'Mo-93m', exemption_level: 10**6, t_medium: hours(6.85) },
            { name: 'Mo-99', exemption_level: 10**6, t_medium: 2.75 },
            { name: 'Mo-101', exemption_level: 10**6, t_medium: hours(0.244) },
        ]
      },
      { short: 'Tc', long: 'Technetium',   mass: 98.9072,   category: 2,
        radionuclides: [
            { name: 'Tc-93', exemption_level: 10**6, t_medium: hours(2.75) },
            { name: 'Tc-93m', exemption_level: 10**6, t_medium: hours(0.725) },
            { name: 'Tc-94', exemption_level: 10**6, t_medium: hours(4.88) },
            { name: 'Tc-94m', exemption_level: 10**5, t_medium: hours(0.867) },
            { name: 'Tc-95', exemption_level: 10**6, t_medium: hours(20.0) },
            { name: 'Tc-95m', exemption_level: 10**6, t_medium: 61 },
            { name: 'Tc-96', exemption_level: 10**6, t_medium: 4.28 },
            { name: 'Tc-96m', exemption_level: 10**7, t_medium: hours(0.858) },
            { name: 'Tc-97', exemption_level: 10**8, t_medium: years(2.60*(10**6)) },
            { name: 'Tc-97m', exemption_level: 10**7, t_medium: 87 },
            { name: 'Tc-98', exemption_level: 10**6, t_medium: years(4.20*(10**6)) },
            { name: 'Tc-99', exemption_level: 10**7, t_medium: years(2.13*(10**5)) },
            { name: 'Tc-99m', exemption_level: 10**7, t_medium: hours(6.02) },
            { name: 'Tc-101', exemption_level: 10**6, t_medium: hours(0.237) },
            { name: 'Tc-104', exemption_level: 10**5, t_medium: hours(0.303) },
        ]
      },
      { short: 'Ru', long: 'Ruthenium',    mass: 101.07,    category: 2,
        radionuclides: [
            { name: 'Ru-94', exemption_level: 10**6, t_medium: hours(0.863) },
            { name: 'Ru-97', exemption_level: 10**7, t_medium: 2.90 },
            { name: 'Ru-103', exemption_level: 10**6, t_medium: 39.3 },
            { name: 'Ru-105', exemption_level: 10**6, t_medium: hours(4.44) },
            { name: 'Ru-106', exemption_level: 10**5, t_medium: years(1.01) },
        ]
      },
      { short: 'Rh', long: 'Rhodium',      mass: 102.9055,  category: 2,
        radionuclides: [
            { name: 'Rh-99', exemption_level: 10**6, t_medium: 16.0 },
            { name: 'Rh-99m', exemption_level: 10**6, t_medium: hours(4.70) },
            { name: 'Rh-100', exemption_level: 10**6, t_medium: hours(20.8) },
            { name: 'Rh-101', exemption_level: 10**7, t_medium: years(3.20) },
            { name: 'Rh-101m', exemption_level: 10**7, t_medium: 4.34 },
            { name: 'Rh-102', exemption_level: 10**6, t_medium: years(2.90) },
            { name: 'Rh-102m', exemption_level: 10**6, t_medium: 207 },
            { name: 'Rh-103m', exemption_level: 10**8, t_medium: hours(0.935) },
            { name: 'Rh-105', exemption_level: 10**7, t_medium: 1.97 },
            { name: 'Rh-106m', exemption_level: 10**5, t_medium: hours(2.20) },
            { name: 'Rh-107', exemption_level: 10**6, t_medium: hours(0.362) },
        ]
      },
      { short: 'Pd', long: 'Palladium',    mass: 106.42,    category: 2,
        radionuclides: [
            { name: 'Pd-100', exemption_level: 10**7, t_medium: 3.63 },
            { name: 'Pd-101', exemption_level: 10**6, t_medium: hours(8.27) },
            { name: 'Pd-103', exemption_level: 10**8, t_medium: 17 },
            { name: 'Pd-107', exemption_level: 10**8, t_medium: years(6.50*(10**6)) },
            { name: 'Pd-109', exemption_level: 10**6, t_medium: hours(13.4) },
        ]
      },
      { short: 'Ag', long: 'Silver',       mass: 107.8682,  category: 2,
        radionuclides: [
            { name: 'Ag-102', exemption_level: 10**5, t_medium: hours(0.215) },
            { name: 'Ag-103', exemption_level: 10**6, t_medium: hours(1.09) },
            { name: 'Ag-104', exemption_level: 10**6, t_medium: hours(1.15) },
            { name: 'Ag-104m', exemption_level: 10**6, t_medium: hours(0.558) },
            { name: 'Ag-105', exemption_level: 10**6, t_medium: 41 },
            { name: 'Ag-106', exemption_level: 10**6, t_medium: hours(0.399) },
            { name: 'Ag-106m', exemption_level: 10**6, t_medium: 8.41 },
            { name: 'Ag-108m', exemption_level: 10**6, t_medium: years(1.27*(10**2)) },
            { name: 'Ag-110m', exemption_level: 10**6, t_medium: 250 },
            { name: 'Ag-111', exemption_level: 10**6, t_medium: 7.45 },
            { name: 'Ag-112', exemption_level: 10**5, t_medium: hours(3.12) },
            { name: 'Ag-115', exemption_level: 10**5, t_medium: hours(3.33) },
        ]
      },
      { short: 'Cd', long: 'Cadmium',      mass: 112.411,   category: 2,
        radionuclides: [
            { name: 'Cd-104', exemption_level: 10**7, t_medium: hours(0.961) },
            { name: 'Cd-107', exemption_level: 10**7, t_medium: hours(6.49) },
            { name: 'Cd-109', exemption_level: 10**6, t_medium: years(1.27) },
            { name: 'Cd-113', exemption_level: 10**6, t_medium: years(9.30*(10**15)) },
            { name: 'Cd-113m', exemption_level: 10**6, t_medium: years(13.6) },
            { name: 'Cd-115', exemption_level: 10**6, t_medium: 2.23 },
            { name: 'Cd-115m', exemption_level: 10**6, t_medium: 44.6 },
            { name: 'Cd-117', exemption_level: 10**6, t_medium: hours(2.49) },
            { name: 'Cd-117m', exemption_level: 10**6, t_medium: hours(3.36) },
        ]
      },
      { short: 'In', long: 'Indium',       mass: 114.818,   category: 3,
        radionuclides: [
            { name: 'In-109', exemption_level: 10**6, t_medium: hours(4.20) },
            { name: 'In-110', exemption_level: 10**6, t_medium: hours(4.90) },
            { name: 'In-110m', exemption_level: 10**5, t_medium: hours(1.15) },
            { name: 'In-111', exemption_level: 10**6, t_medium: 2.83 },
            { name: 'In-112', exemption_level: 10**6, t_medium: hours(0.240) },
            { name: 'In-113m', exemption_level: 10**6, t_medium: hours(1.66) },
            { name: 'In-114', exemption_level: 10**5, t_medium: nil },
            { name: 'In-114m', exemption_level: 10**6, t_medium: 49.5 },
            { name: 'In-115', exemption_level: 10**5, t_medium: years(5.10*(10**15)) },
            { name: 'In-115m', exemption_level: 10**6, t_medium: hours(4.49) },
            { name: 'In-116m', exemption_level: 10**5, t_medium: hours(0.902) },
            { name: 'In-117', exemption_level: 10**6, t_medium: hours(0.730) },
            { name: 'In-117m', exemption_level: 10**6, t_medium: hours(1.94) },
            { name: 'In-119m', exemption_level: 10**5, t_medium: hours(0.300) },
        ]
      },
      { short: 'Sn', long: 'Tin',          mass: 118.71,    category: 3,
        radionuclides: [
            { name: 'Sn-110', exemption_level: 10**7, t_medium: hours(4) },
            { name: 'Sn-111', exemption_level: 10**6, t_medium: hours(0.588) },
            { name: 'Sn-113', exemption_level: 10**7, t_medium: 115 },
            { name: 'Sn-117m', exemption_level: 10**6, t_medium: 13.6 },
            { name: 'Sn-119m', exemption_level: 10**7, t_medium: 293 },
            { name: 'Sn-121', exemption_level: 10**7, t_medium: 1.13 },
            { name: 'Sn-121m', exemption_level: 10**7, t_medium: years(55) },
            { name: 'Sn-123', exemption_level: 10**6, t_medium: 129 },
            { name: 'Sn-123m', exemption_level: 10**6, t_medium: hours(0.668) },
            { name: 'Sn-125', exemption_level: 10**5, t_medium: 9.64 },
            { name: 'Sn-126', exemption_level: 10**5, t_medium: years(10**5) },
            { name: 'Sn-127', exemption_level: 10**6, t_medium: hours(2.10) },
            { name: 'Sn-128', exemption_level: 10**6, t_medium: hours(0.985) },
        ]
      },    # 50
      { short: 'Sb', long: 'Antimony',     mass: 121.760,   category: 4,
        radionuclides: [
            { name: 'Sb-115', exemption_level: 10**6, t_medium: hours(0.530) },
            { name: 'Sb-116', exemption_level: 10**6, t_medium: hours(0.263) },
            { name: 'Sb-116m', exemption_level: 10**5, t_medium: hours(1) },
            { name: 'Sb-117', exemption_level: 10**7, t_medium: hours(2.80) },
            { name: 'Sb-118m', exemption_level: 10**6, t_medium: hours(5) },
            { name: 'Sb-119', exemption_level: 10**7, t_medium: 1.59 },
            { name: 'Sb-120', exemption_level: 10**6, t_medium: hours(0.265) },
            { name: 'Sb-120m', exemption_level: 10**6, t_medium: 5.76 },
            { name: 'Sb-122', exemption_level: 10**4, t_medium: 2.70 },
            { name: 'Sb-124', exemption_level: 10**6, t_medium: 60.2 },
            { name: 'Sb-124m', exemption_level: 10**6, t_medium: hours(0.337) },
            { name: 'Sb-125', exemption_level: 10**6, t_medium: years(2.77) },
            { name: 'Sb-126', exemption_level: 10**5, t_medium: 12.4 },
            { name: 'Sb-126m', exemption_level: 10**5, t_medium: hours(0.317) },
            { name: 'Sb-127', exemption_level: 10**6, t_medium: 3.85 },
            { name: 'Sb-128', exemption_level: 10**5, t_medium: hours(9.01) },
            { name: 'Sb-128m', exemption_level: 10**5, t_medium: hours(0.173) },
            { name: 'Sb-129', exemption_level: 10**6, t_medium: hours(4.32) },
            { name: 'Sb-130', exemption_level: 10**5, t_medium: hours(0.667) },
            { name: 'Sb-131', exemption_level: 10**6, t_medium: hours(0.383) },
        ]
      },
      { short: 'Te', long: 'Tellurium',    mass: 127.6,     category: 4,
        radionuclides: [
            { name: 'Te-116', exemption_level: 10**7, t_medium: hours(2.49) },
            { name: 'Te-121', exemption_level: 10**6, t_medium: 17 },
            { name: 'Te-121m', exemption_level: 10**6, t_medium: 154 },
            { name: 'Te-123', exemption_level: 10**6, t_medium: years(10**13) },
            { name: 'Te-123m', exemption_level: 10**7, t_medium: 120 },
            { name: 'Te-125m', exemption_level: 10**7, t_medium: 58 },
            { name: 'Te-127', exemption_level: 10**6, t_medium: hours(9.35) },
            { name: 'Te-127m', exemption_level: 10**7, t_medium: 109 },
            { name: 'Te-129', exemption_level: 10**6, t_medium: hours 1.16 },
            { name: 'Te-129m', exemption_level: 10**6, t_medium: 33.6 },
            { name: 'Te-131', exemption_level: 10**5, t_medium: hours 0.417 },
            { name: 'Te-131m', exemption_level: 10**6, t_medium: 1.25 },
            { name: 'Te-132', exemption_level: 10**7, t_medium: 3.26 },
            { name: 'Te-133', exemption_level: 10**5, t_medium: hours 0.207 },
            { name: 'Te-133m', exemption_level: 10**5, t_medium: hours 0.923 },
            { name: 'Te-134', exemption_level: 10**6, t_medium: hours 0.696 },
        ]
      },
      { short: 'I',  long: 'Iodine',       mass: 126.90447, category: 6,
        radionuclides: [
            { name: 'I-120', exemption_level: 10**5, t_medium: hours 1.35 },
            { name: 'I-120m', exemption_level: 10**5, t_medium: hours 0.883 },
            { name: 'I-121', exemption_level: 10**6, t_medium: hours 2.12 },
            { name: 'I-123', exemption_level: 10**7, t_medium: hours 13.2 },
            { name: 'I-124', exemption_level: 10**6, t_medium: 4.18 },
            { name: 'I-125', exemption_level: 10**6, t_medium: 60.1 },
            { name: 'I-126', exemption_level: 10**6, t_medium: 13 },
            { name: 'I-128', exemption_level: 10**5, t_medium: hours 0.416 },
            { name: 'I-129', exemption_level: 10**5, t_medium: years 1.57*(10**7) },
            { name: 'I-130', exemption_level: 10**6, t_medium: hours 12.4 },
            { name: 'I-131', exemption_level: 10**6, t_medium: 8.04 },
            { name: 'I-132', exemption_level: 10**5, t_medium: hours 2.30 },
            { name: 'I-132m', exemption_level: 10**6, t_medium: hours 1.39 },
            { name: 'I-133', exemption_level: 10**6, t_medium: hours 20.8 },
            { name: 'I-134', exemption_level: 10**5, t_medium: hours 0.876 },
            { name: 'I-135', exemption_level: 10**6, t_medium: hours 6.61 },
        ]
      },
      { short: 'Xe', long: 'Xenon',        mass: 131.29,    category: 7,
        radionuclides: [
            { name: 'Xe-120', exemption_level: 10**9, t_medium: nil },
            { name: 'Xe-121', exemption_level: 10**9, t_medium: nil },
            { name: 'Xe-122', exemption_level: 10**9, t_medium: nil },
            { name: 'Xe-123', exemption_level: 10**9, t_medium: nil },
            { name: 'Xe-125', exemption_level: 10**9, t_medium: nil },
            { name: 'Xe-127', exemption_level: 10**5, t_medium: nil },
            { name: 'Xe-129m', exemption_level: 10**4, t_medium: nil },
            { name: 'Xe-131m', exemption_level: 10**4, t_medium: nil },
            { name: 'Xe-133', exemption_level: 10**4, t_medium: nil },
            { name: 'Xe-133m', exemption_level: 10**4, t_medium: nil },
            { name: 'Xe-135', exemption_level: 10**10, t_medium: nil },
            { name: 'Xe-135m', exemption_level: 10**9, t_medium: nil },
            { name: 'Xe-138', exemption_level: 10**9, t_medium: nil },
        ]
      },
      { short: 'Cs', long: 'Cesium',       mass: 132.90543, category: 0,
        radionuclides: [
            { name: 'Cs-125', exemption_level: 10**4, t_medium: hours(0.750) },
            { name: 'Cs-127', exemption_level: 10**5, t_medium: hours(6.25) },
            { name: 'Cs-129', exemption_level: 10**5, t_medium: 1.34 },
            { name: 'Cs-130', exemption_level: 10**6, t_medium: hours(0.498) },
            { name: 'Cs-131', exemption_level: 10**6, t_medium: 9.69 },
            { name: 'Cs-132', exemption_level: 10**5, t_medium: 6.48 },
            { name: 'Cs-134', exemption_level: 10**5, t_medium: years(2.06) },
            { name: 'Cs-134m', exemption_level: 10**4, t_medium: hours(2.90) },
            { name: 'Cs-135', exemption_level: 10**7, t_medium: years(2.30*(10**6)) },
            { name: 'Cs-135m', exemption_level: 10**6, t_medium: hours(0.883) },
            { name: 'Cs-136', exemption_level: 10**5, t_medium: 13.1 },
            { name: 'Cs-137', exemption_level: 10**4, t_medium: years(30) },
            { name: 'Cs-138', exemption_level: 10**4, t_medium: hours(0.536) },
        ]
      },
      { short: 'Ba', long: 'Barium',       mass: 137.327,   category: 1,
        radionuclides: [
            { name: 'Ba-126', exemption_level: 10**7, t_medium: hours(1.61) },
            { name: 'Ba-128', exemption_level: 10**7, t_medium: 2.43 },
            { name: 'Ba-131', exemption_level: 10**6, t_medium: 11.8 },
            { name: 'Ba-131m', exemption_level: 10**7, t_medium: hours(0.243) },
            { name: 'Ba-133', exemption_level: 10**6, t_medium: years(10.7) },
            { name: 'Ba-133m', exemption_level: 10**6, t_medium: 1.62 },
            { name: 'Ba-135m', exemption_level: 10**6, t_medium: 1.20 },
            { name: 'Ba-137m', exemption_level: 10**6, t_medium: nil },
            { name: 'Ba-139', exemption_level: 10**5, t_medium: hours(1.38) },
            { name: 'Ba-140', exemption_level: 10**5, t_medium: 12.7 },
            { name: 'Ba-141', exemption_level: 10**5, t_medium: hours(0.305) },
            { name: 'Ba-142', exemption_level: 10**2, t_medium: hours(0.177) },
        ]
      },

      { short: 'La', long: 'Lanthanum',    mass: 138.9055,  category:  8,
        radionuclides: [
            { name: 'La-131', exemption_level: 10**6, t_medium: hours(0.983) },
            { name: 'La-132', exemption_level: 10**6, t_medium: hours(4.80) },
            { name: 'La-135', exemption_level: 10**7, t_medium: hours(19.5) },
            { name: 'La-137', exemption_level: 10**7, t_medium: years(6*(10**4)) },
            { name: 'La-138', exemption_level: 10**6, t_medium: years(1.35*(10**11)) },
            { name: 'La-140', exemption_level: 10**5, t_medium: 1.68 },
            { name: 'La-141', exemption_level: 10**5, t_medium: hours(3.93) },
            { name: 'La-142', exemption_level: 10**5, t_medium: hours(1.54) },
            { name: 'La-143', exemption_level: 10**5, t_medium: hours(0.237) },
        ]
      },
      { short: 'Ce', long: 'Cerium',       mass: 140.115,   category:  8,
        radionuclides: [
            { name: 'Ce-134', exemption_level: 10**7, t_medium: 3 },
            { name: 'Ce-135', exemption_level: 10**6, t_medium: hours(17.6) },
            { name: 'Ce-137', exemption_level: 10**7, t_medium: hours(9) },
            { name: 'Ce-137m', exemption_level: 10**6, t_medium: 1.43 },
            { name: 'Ce-139', exemption_level: 10**6, t_medium: 138 },
            { name: 'Ce-141', exemption_level: 10**7, t_medium: 32.5 },
            { name: 'Ce-143', exemption_level: 10**6, t_medium: 1.38 },
            { name: 'Ce-144', exemption_level: 10**5, t_medium: 284 },
        ]
      },
      { short: 'Pr', long: 'Praseodymium', mass: 140.90765, category:  8,
        radionuclides: [
            { name: 'Pr-136', exemption_level: 10**5, t_medium: hours(0.218) },
            { name: 'Pr-137', exemption_level: 10**6, t_medium: hours(1.28) },
            { name: 'Pr-138m', exemption_level: 10**6, t_medium: hours(2.10) },
            { name: 'Pr-139', exemption_level: 10**7, t_medium: hours(4.51) },
            { name: 'Pr-142', exemption_level: 10**5, t_medium: hours(19.1) },
            { name: 'Pr-142m', exemption_level: 10**9, t_medium: hours(0.243) },
            { name: 'Pr-143', exemption_level: 10**6, t_medium: 13.6 },
            { name: 'Pr-144', exemption_level: 10**5, t_medium: hours(0.288) },
            { name: 'Pr-145', exemption_level: 10**5, t_medium: hours(5.98) },
            { name: 'Pr-147', exemption_level: 10**5, t_medium: hours(0.227) },
        ]
      },
      { short: 'Nd', long: 'Neodymium',    mass: 144.24,    category:  8,
        radionuclides: [
            { name: 'Nd-136', exemption_level: 10**6, t_medium: hours(0.844) },
            { name: 'Nd-138', exemption_level: 10**7, t_medium: hours(5.04) },
            { name: 'Nd-139', exemption_level: 10**6, t_medium: hours(0.495) },
            { name: 'Nd-139m', exemption_level: 10**6, t_medium: hours(5.50) },
            { name: 'Nd-141', exemption_level: 10**7, t_medium: hours(2.49) },
            { name: 'Nd-147', exemption_level: 10**6, t_medium: 11 },
            { name: 'Nd-149', exemption_level: 10**6, t_medium: hours(1.73) },
            { name: 'Nd-151', exemption_level: 10**5, t_medium: hours(0.207) },
        ]
      },   # 60
      { short: 'Pm', long: 'Promethium',   mass: 144.9127,  category:  8,
        radionuclides: [
            { name: 'Pm-141', exemption_level: 10**5, t_medium: hours(0.348) },
            { name: 'Pm-143', exemption_level: 10**6, t_medium: 265 },
            { name: 'Pm-144', exemption_level: 10**6, t_medium: 363 },
            { name: 'Pm-145', exemption_level: 10**7, t_medium: years(17.7) },
            { name: 'Pm-146', exemption_level: 10**6, t_medium: years(5.53) },
            { name: 'Pm-147', exemption_level: 10**7, t_medium: years(2.62) },
            { name: 'Pm-148', exemption_level: 10**5, t_medium: 5.37 },
            { name: 'Pm-148m', exemption_level: 10**6, t_medium: 41.3 },
            { name: 'Pm-149', exemption_level: 10**6, t_medium: 2.21 },
            { name: 'Pm-150', exemption_level: 10**5, t_medium: hours(2.68) },
            { name: 'Pm-151', exemption_level: 10**6, t_medium: 1.18 },
        ]
      },
      { short: 'Sm', long: 'Samarium',     mass: 150.36,    category:  8,
        radionuclides: [
            { name: 'Sm-141', exemption_level: 10**5, t_medium: hours(0.170) },
            { name: 'Sm-141m', exemption_level: 10**6, t_medium: hours(0.377) },
            { name: 'Sm-142', exemption_level: 10**7, t_medium: hours(1.21) },
            { name: 'Sm-145', exemption_level: 10**7, t_medium: 340 },
            { name: 'Sm-146', exemption_level: 10**5, t_medium: years(1.03*(10**8)) },
            { name: 'Sm-147', exemption_level: 10**4, t_medium: years(1.06*(10**11)) },
            { name: 'Sm-151', exemption_level: 10**8, t_medium: years(90) },
            { name: 'Sm-153', exemption_level: 10**6, t_medium: 1.95 },
            { name: 'Sm-155', exemption_level: 10**6, t_medium: hours(0.368) },
            { name: 'Sm-156', exemption_level: 10**6, t_medium: hours(9.40) },
        ]
      },
      { short: 'Eu', long: 'Europium',     mass: 151.9655,  category:  8,
        radionuclides: [
            { name: 'Eu-145', exemption_level: 10**6, t_medium: 5.94 },
            { name: 'Eu-146', exemption_level: 10**6, t_medium: 4.61 },
            { name: 'Eu-147', exemption_level: 10**6, t_medium: 24 },
            { name: 'Eu-148', exemption_level: 10**6, t_medium: 54.5 },
            { name: 'Eu-149', exemption_level: 10**7, t_medium: 93.1 },
            { name: 'Eu-150', exemption_level: 10**6, t_medium: years(34.2) },
            { name: 'Eu-150m', exemption_level: 10**6, t_medium: hours(12.6) },
            { name: 'Eu-152', exemption_level: 10**6, t_medium: years(13.3) },
            { name: 'Eu-152m', exemption_level: 10**6, t_medium: hours(9..32) },
            { name: 'Eu-154', exemption_level: 10**6, t_medium: years(8.80) },
            { name: 'Eu-155', exemption_level: 10**7, t_medium: years(4.96) },
            { name: 'Eu-156', exemption_level: 10**6, t_medium: 15.2 },
            { name: 'Eu-157', exemption_level: 10**6, t_medium: hours(15.1) },
            { name: 'Eu-158', exemption_level: 10**5, t_medium: hours(0.765) },
        ]
      },
      { short: 'Gd', long: 'Gadolinium',   mass: 157.25,    category:  8,
        radionuclides: [
            { name: 'Gd-145', exemption_level: 10**5, t_medium: hours(0.382) },
            { name: 'Gd-146', exemption_level: 10**6, t_medium: 48.3 },
            { name: 'Gd-147', exemption_level: 10**6, t_medium: 1.59 },
            { name: 'Gd-148', exemption_level: 10**4, t_medium: years(93) },
            { name: 'Gd-149', exemption_level: 10**6, t_medium: 9.4 },
            { name: 'Gd-151', exemption_level: 10**7, t_medium: 120 },
            { name: 'Gd-152', exemption_level: 10**4, t_medium: years(1.08*(10**14)) },
            { name: 'Gd-153', exemption_level: 10**7, t_medium: 242 },
            { name: 'Gd-159', exemption_level: 10**6, t_medium: hours(18.6) },
        ]
      },
      { short: 'Tb', long: 'Terbium',      mass: 158.92534, category:  8,
        radionuclides: [
            { name: 'Tb-147', exemption_level: 10**6, t_medium: hours(1.65) },
            { name: 'Tb-149', exemption_level: 10**6, t_medium: hours(4.15) },
            { name: 'Tb-150', exemption_level: 10**6, t_medium: hours(3.27) },
            { name: 'Tb-151', exemption_level: 10**6, t_medium: hours(17.6) },
            { name: 'Tb-153', exemption_level: 10**7, t_medium: 2.34 },
            { name: 'Tb-154', exemption_level: 10**6, t_medium: hours(21.4) },
            { name: 'Tb-155', exemption_level: 10**7, t_medium: 5.32 },
            { name: 'Tb-156', exemption_level: 10**6, t_medium: 5.34 },
            { name: 'Tb-156m', exemption_level: 10**7, t_medium: 1.02 },
            { name: 'Tb-156mp', exemption_level: 10**7, t_medium: hours(5) },
            { name: 'Tb-157', exemption_level: 10**7, t_medium: years(7.1*10) },
            { name: 'Tb-158', exemption_level: 10**6, t_medium: years(1.80*(10**2)) },
            { name: 'Tb-160', exemption_level: 10**6, t_medium: 72.3 },
            { name: 'Tb-161', exemption_level: 10**6, t_medium: 6.91 },
        ]
      },
      { short: 'Dy', long: 'Dysprosium',   mass: 162.50,    category:  8,
        radionuclides: [
            { name: 'Dy-155', exemption_level: 10**6, t_medium: hours(10) },
            { name: 'Dy-157', exemption_level: 10**6, t_medium: hours(8.10) },
            { name: 'Dy-159', exemption_level: 10**7, t_medium: 144 },
            { name: 'Dy-165', exemption_level: 10**6, t_medium: hours(2.33) },
            { name: 'Dy-166', exemption_level: 10**6, t_medium: 3.40 },
        ]
      },
      { short: 'Ho', long: 'Holmium',      mass: 164.93032, category:  8,
        radionuclides: [
            { name: 'Ho-155', exemption_level: 10**6, t_medium: hours(0.800) },
            { name: 'Ho-157', exemption_level: 10**6, t_medium: hours(0.210) },
            { name: 'Ho-159', exemption_level: 10**6, t_medium: hours(0.550) },
            { name: 'Ho-161', exemption_level: 10**7, t_medium: hours(2.50) },
            { name: 'Ho-162', exemption_level: 10**7, t_medium: hours(0.250) },
            { name: 'Ho-162m', exemption_level: 10**6, t_medium: hours(1.13) },
            { name: 'Ho-164', exemption_level: 10**6, t_medium: hours(0.483) },
            { name: 'Ho-164m', exemption_level: 10**7, t_medium: hours(0.625) },
            { name: 'Ho-166', exemption_level: 10**5, t_medium: 1.12 },
            { name: 'Ho-166m', exemption_level: 10**6, t_medium: years(1.20*(10**3)) },
            { name: 'Ho-167', exemption_level: 10**6, t_medium: hours(3.10) },
        ]
      },
      { short: 'Er', long: 'Erbium',       mass: 167.26,    category:  8,
        radionuclides: [
            { name: 'Er-161', exemption_level: 10**6, t_medium: hours(3.24) },
            { name: 'Er-165', exemption_level: 10**7, t_medium: hours(10.4) },
            { name: 'Er-169', exemption_level: 10**7, t_medium: 9.30 },
            { name: 'Er-171', exemption_level: 10**6, t_medium: hours(7.52) },
            { name: 'Er-172', exemption_level: 10**6, t_medium: 2.05 },
        ]
      },
      { short: 'Tm', long: 'Thulium',      mass: 168.93421, category:  8,
        radionuclides: [
            { name: 'Tm-162', exemption_level: 10**6, t_medium: hours(0.362) },
            { name: 'Tm-166', exemption_level: 10**7, t_medium: hours(7.70) },
            { name: 'Tm-167', exemption_level: 10**6, t_medium: 9.24 },
            { name: 'Tm-170', exemption_level: 10**6, t_medium: 129 },
            { name: 'Tm-171', exemption_level: 10**8, t_medium: years(1.92) },
            { name: 'Tm-172', exemption_level: 10**6, t_medium: 2.65 },
            { name: 'Tm-173', exemption_level: 10**6, t_medium: hours(8.24) },
            { name: 'Tm-175', exemption_level: 10**6, t_medium: hours(0.253) },
        ]
      },
      { short: 'Yb', long: 'Ytterbium',    mass: 173.04,    category:  8,
        radionuclides: [
            { name: 'Yb-162', exemption_level: 10**7, t_medium: nil },
            { name: 'Yb-166', exemption_level: 10**7, t_medium: nil },
            { name: 'Yb-167', exemption_level: 10**6, t_medium: nil },
            { name: 'Yb-169', exemption_level: 10**7, t_medium: nil },
            { name: 'Yb-175', exemption_level: 10**7, t_medium: nil },
            { name: 'Yb-177', exemption_level: 10**6, t_medium: nil },
            { name: 'Yb-178', exemption_level: 10**6, t_medium: nil },
        ]
      },   # 70
      { short: 'Lu', long: 'Lutetium',     mass: 174.967,   category:  8,
        radionuclides: [
            { name: 'Lu-169', exemption_level: 10**6, t_medium: nil },
            { name: 'Lu-170', exemption_level: 10**6, t_medium: nil },
            { name: 'Lu-171', exemption_level: 10**6, t_medium: nil },
            { name: 'Lu-172', exemption_level: 10**6, t_medium: nil },
            { name: 'Lu-173', exemption_level: 10**7, t_medium: nil },
            { name: 'Lu-174', exemption_level: 10**7, t_medium: nil },
            { name: 'Lu-174m', exemption_level: 10**7, t_medium: nil },
            { name: 'Lu-176', exemption_level: 10**6, t_medium: nil },
            { name: 'Lu-176m', exemption_level: 10**6, t_medium: nil },
            { name: 'Lu-177', exemption_level: 10**7, t_medium: nil },
            { name: 'Lu-177m', exemption_level: 10**6, t_medium: nil },
            { name: 'Lu-178', exemption_level: 10**5, t_medium: nil },
            { name: 'Lu-178m', exemption_level: 10**5, t_medium: nil },
            { name: 'Lu-179', exemption_level: 10**6, t_medium: nil },
        ]
      },

      { short: 'Hf', long: 'Hafnium',      mass: 178.49,    category:  2,
        radionuclides: [
            { name: 'Hf-170', exemption_level: 10**6, t_medium: nil },
            { name: 'Hf-172', exemption_level: 10**6, t_medium: nil },
            { name: 'Hf-173', exemption_level: 10**6, t_medium: nil },
            { name: 'Hf-175', exemption_level: 10**6, t_medium: nil },
            { name: 'Hf-177m', exemption_level: 10**5, t_medium: nil },
            { name: 'Hf-178m', exemption_level: 10**6, t_medium: nil },
            { name: 'Hf-179m', exemption_level: 10**6, t_medium: nil },
            { name: 'Hf-180m', exemption_level: 10**6, t_medium: nil },
            { name: 'Hf-181', exemption_level: 10**6, t_medium: nil },
            { name: 'Hf-182', exemption_level: 10**6, t_medium: nil },
            { name: 'Hf-182m', exemption_level: 10**6, t_medium: nil },
            { name: 'Hf-183', exemption_level: 10**6, t_medium: nil },
            { name: 'Hf-184', exemption_level: 10**6, t_medium: nil },
        ]
      },
      { short: 'Ta', long: 'Tantalum',     mass: 180.9479,  category:  2,
        radionuclides: [
            { name: 'Ta-172', exemption_level: 10**6, t_medium: nil },
            { name: 'Ta-173', exemption_level: 10**6, t_medium: nil },
            { name: 'Ta-174', exemption_level: 10**6, t_medium: nil },
            { name: 'Ta-175', exemption_level: 10**6, t_medium: nil },
            { name: 'Ta-176', exemption_level: 10**6, t_medium: nil },
            { name: 'Ta-177', exemption_level: 10**7, t_medium: nil },
            { name: 'Ta-178', exemption_level: 10**6, t_medium: nil },
            { name: 'Ta-179', exemption_level: 10**7, t_medium: nil },
            { name: 'Ta-180', exemption_level: 10**6, t_medium: nil },
            { name: 'Ta-180m', exemption_level: 10**7, t_medium: nil },
            { name: 'Ta-182', exemption_level: 10**4, t_medium: nil },
            { name: 'Ta-182m', exemption_level: 10**6, t_medium: nil },
            { name: 'Ta-183', exemption_level: 10**6, t_medium: nil },
            { name: 'Ta-184', exemption_level: 10**6, t_medium: nil },
            { name: 'Ta-185', exemption_level: 10**5, t_medium: nil },
            { name: 'Ta-186', exemption_level: 10**5, t_medium: nil },
        ]
      },
      { short: 'W',  long: 'Tungsten',     mass: 183.85,    category:  2,
        radionuclides: [
            { name: 'W-176', exemption_level: 10**6, t_medium: nil },
            { name: 'W-177', exemption_level: 10**6, t_medium: nil },
            { name: 'W-178', exemption_level: 10**6, t_medium: nil },
            { name: 'W-179', exemption_level: 10**7, t_medium: nil },
            { name: 'W-181', exemption_level: 10**7, t_medium: nil },
            { name: 'W-185', exemption_level: 10**7, t_medium: nil },
            { name: 'W-187', exemption_level: 10**6, t_medium: nil },
            { name: 'W-188', exemption_level: 10**5, t_medium: nil },
        ]
      },
      { short: 'Re', long: 'Rhenium',      mass: 186.207,   category:  2,
        radionuclides: [
            { name: 'Re-177', exemption_level: 10**6, t_medium: nil },
            { name: 'Re-178', exemption_level: 10**6, t_medium: nil },
            { name: 'Re-181', exemption_level: 10**6, t_medium: nil },
            { name: 'Re-182', exemption_level: 10**6, t_medium: nil },
            { name: 'Re-182m', exemption_level: 10**6, t_medium: nil },
            { name: 'Re-184', exemption_level: 10**6, t_medium: nil },
            { name: 'Re-184m', exemption_level: 10**6, t_medium: nil },
            { name: 'Re-186', exemption_level: 10**6, t_medium: nil },
            { name: 'Re-186m', exemption_level: 10**7, t_medium: nil },
            { name: 'Re-187', exemption_level: 10**9, t_medium: nil },
            { name: 'Re-188', exemption_level: 10**5, t_medium: nil },
            { name: 'Re-188m', exemption_level: 10**7, t_medium: nil },
            { name: 'Re-189', exemption_level: 10**6, t_medium: nil },
        ]
      },
      { short: 'Os', long: 'Osmium',       mass: 190.23,    category:  2,
        radionuclides: [
            { name: 'Os-180', exemption_level: 10**7, t_medium: nil },
            { name: 'Os-181', exemption_level: 10**6, t_medium: nil },
            { name: 'Os-182', exemption_level: 10**6, t_medium: nil },
            { name: 'Os-185', exemption_level: 10**6, t_medium: nil },
            { name: 'Os-189m', exemption_level: 10**7, t_medium: nil },
            { name: 'Os-191', exemption_level: 10**7, t_medium: nil },
            { name: 'Os-191m', exemption_level: 10**7, t_medium: nil },
            { name: 'Os-193', exemption_level: 10**6, t_medium: nil },
            { name: 'Os-194', exemption_level: 10**5, t_medium: nil },
        ]
      },
      { short: 'Ir', long: 'Iridium',      mass: 192.22,    category:  2,
        radionuclides: [
            { name: 'Ir-182', exemption_level: 10**5, t_medium: nil },
            { name: 'Ir-184', exemption_level: 10**6, t_medium: nil },
            { name: 'Ir-185', exemption_level: 10**6, t_medium: nil },
            { name: 'Ir-186', exemption_level: 10**6, t_medium: nil },
            { name: 'Ir-186m', exemption_level: 10**6, t_medium: nil },
            { name: 'Ir-187', exemption_level: 10**6, t_medium: nil },
            { name: 'Ir-188', exemption_level: 10**6, t_medium: nil },
            { name: 'Ir-189', exemption_level: 10**7, t_medium: nil },
            { name: 'Ir-190', exemption_level: 10**6, t_medium: nil },
            { name: 'Ir-190m', exemption_level: 10**6, t_medium: nil },
            { name: 'Ir-190mp', exemption_level: 10**7, t_medium: nil },
            { name: 'Ir-192', exemption_level: 10**4, t_medium: nil },
            { name: 'Ir-192m', exemption_level: 10**7, t_medium: nil },
            { name: 'Ir-193m', exemption_level: 10**7, t_medium: nil },
            { name: 'Ir-194', exemption_level: 10**5, t_medium: nil },
            { name: 'Ir-194m', exemption_level: 10**6, t_medium: nil },
            { name: 'Ir-195', exemption_level: 10**6, t_medium: nil },
            { name: 'Ir-195m', exemption_level: 10**6, t_medium: nil },
        ]
      },
      { short: 'Pt', long: 'Platinum',     mass: 195.08,    category:  2,
        radionuclides: [
            { name: 'Pt-186', exemption_level: 10**6, t_medium: nil },
            { name: 'Pt-188', exemption_level: 10**6, t_medium: nil },
            { name: 'Pt-189', exemption_level: 10**6, t_medium: nil },
            { name: 'Pt-191', exemption_level: 10**6, t_medium: nil },
            { name: 'Pt-193', exemption_level: 10**7, t_medium: nil },
            { name: 'Pt-193m', exemption_level: 10**7, t_medium: nil },
            { name: 'Pt-195m', exemption_level: 10**6, t_medium: nil },
            { name: 'Pt-197', exemption_level: 10**6, t_medium: nil },
            { name: 'Pt-197m', exemption_level: 10**6, t_medium: nil },
            { name: 'Pt-199', exemption_level: 10**6, t_medium: nil },
            { name: 'Pt-200', exemption_level: 10**6, t_medium: nil },
        ]
      },
      { short: 'Au', long: 'Gold',         mass: 196.9665,  category:  2,
        radionuclides: [
            { name: 'Au-193', exemption_level: 10**7, t_medium: nil },
            { name: 'Au-194', exemption_level: 10**6, t_medium: nil },
            { name: 'Au-195', exemption_level: 10**7, t_medium: nil },
            { name: 'Au-198', exemption_level: 10**6, t_medium: nil },
            { name: 'Au-198m', exemption_level: 10**6, t_medium: nil },
            { name: 'Au-199', exemption_level: 10**6, t_medium: nil },
            { name: 'Au-200', exemption_level: 10**5, t_medium: nil },
            { name: 'Au-200m', exemption_level: 10**6, t_medium: nil },
            { name: 'Au-201', exemption_level: 10**6, t_medium: nil },
        ]
      },
      { short: 'Hg', long: 'Mercury',      mass: 200.59,    category:  2,
        radionuclides: [
            { name: 'Hg-193', exemption_level: 10**6, t_medium: nil },
            { name: 'Hg-193m', exemption_level: 10**6, t_medium: nil },
            { name: 'Hg-194', exemption_level: 10**6, t_medium: nil },
            { name: 'Hg-195', exemption_level: 10**6, t_medium: nil },
            { name: 'Hg-195m', exemption_level: 10**6, t_medium: nil },
            { name: 'Hg-197', exemption_level: 10**7, t_medium: nil },
            { name: 'Hg-197m', exemption_level: 10**6, t_medium: nil },
            { name: 'Hg-199m', exemption_level: 10**6, t_medium: nil },
            { name: 'Hg-203', exemption_level: 10**2, t_medium: nil },
        ]
      },   # 80
      { short: 'Tl', long: 'Thallium',     mass: 204.3833,  category:  3,
        radionuclides: [
            { name: 'Tl-194', exemption_level: 10**6, t_medium: nil },
            { name: 'Tl-194m', exemption_level: 10**6, t_medium: nil },
            { name: 'Tl-195', exemption_level: 10**6, t_medium: nil },
            { name: 'Tl-197', exemption_level: 10**6, t_medium: nil },
            { name: 'Tl-198', exemption_level: 10**6, t_medium: nil },
            { name: 'Tl-198m', exemption_level: 10**6, t_medium: nil },
            { name: 'Tl-199', exemption_level: 10**6, t_medium: nil },
            { name: 'Tl-200', exemption_level: 10**6, t_medium: nil },
            { name: 'Tl-201', exemption_level: 10**6, t_medium: nil },
            { name: 'Tl-202', exemption_level: 10**6, t_medium: nil },
            { name: 'Tl-204', exemption_level: 10**4, t_medium: nil },
        ]
      },
      { short: 'Pb', long: 'Lead',         mass: 204.3833,  category:  3,
        radionuclides: [
            { name: 'Pb-195m', exemption_level: 10**6, t_medium: nil },
            { name: 'Pb-198', exemption_level: 10**6, t_medium: nil },
            { name: 'Pb-199', exemption_level: 10**6, t_medium: nil },
            { name: 'Pb-200', exemption_level: 10**6, t_medium: nil },
            { name: 'Pb-201', exemption_level: 10**6, t_medium: nil },
            { name: 'Pb-202', exemption_level: 10**6, t_medium: nil },
            { name: 'Pb-202m', exemption_level: 10**6, t_medium: nil },
            { name: 'Pb-203', exemption_level: 10**6, t_medium: nil },
            { name: 'Pb-205', exemption_level: 10**7, t_medium: nil },
            { name: 'Pb-209', exemption_level: 10**6, t_medium: nil },
            { name: 'Pb-210', exemption_level: 10**4, t_medium: nil },
            { name: 'Pb-211', exemption_level: 10**6, t_medium: nil },
            { name: 'Pb-212', exemption_level: 10**5, t_medium: nil },
            { name: 'Pb-214', exemption_level: 10**6, t_medium: nil },
        ]
      },
      { short: 'Bi', long: 'Bismuth',      mass: 208.98037, category:  3,
        radionuclides: [
            { name: 'Bi-200', exemption_level: 10**6, t_medium: nil },
            { name: 'Bi-201', exemption_level: 10**6, t_medium: nil },
            { name: 'Bi-202', exemption_level: 10**6, t_medium: nil },
            { name: 'Bi-203', exemption_level: 10**6, t_medium: nil },
            { name: 'Bi-205', exemption_level: 10**6, t_medium: nil },
            { name: 'Bi-206', exemption_level: 10**5, t_medium: nil },
            { name: 'Bi-207', exemption_level: 10**6, t_medium: nil },
            { name: 'Bi-210', exemption_level: 10**6, t_medium: nil },
            { name: 'Bi-210m', exemption_level: 10**5, t_medium: nil },
            { name: 'Bi-212', exemption_level: 10**5, t_medium: nil },
            { name: 'Bi-213', exemption_level: 10**6, t_medium: nil },
            { name: 'Bi-214', exemption_level: 10**5, t_medium: nil },
        ]
      },
      { short: 'Po', long: 'Polonium',     mass: 208.9824,  category:  4,
        radionuclides: [
            { name: 'Po-203', exemption_level: 10**6, t_medium: nil },
            { name: 'Po-205', exemption_level: 10**6, t_medium: nil },
            { name: 'Po-206', exemption_level: 10**6, t_medium: nil },
            { name: 'Po-207', exemption_level: 10**6, t_medium: nil },
            { name: 'Po-208', exemption_level: 10**4, t_medium: nil },
            { name: 'Po-209', exemption_level: 10**4, t_medium: nil },
            { name: 'Po-210', exemption_level: 10**4, t_medium: nil },
        ]
      },
      { short: 'At', long: 'Astatine',     mass: 209.9871,  category:  6,
        radionuclides: [
            { name: 'At-207', exemption_level: 10**6, t_medium: nil },
            { name: 'At-211', exemption_level: 10**7, t_medium: nil },
        ]
      },
      { short: 'Rn', long: 'Radon',        mass: 222.0176,  category:  7,
        radionuclides: [
            { name: 'Rn-220', exemption_level: 10**7, t_medium: nil },
            { name: 'Rn-222', exemption_level: 10**8, t_medium: nil },
        ]
      },
      { short: 'Fr', long: 'Francium',     mass: 223.0197,  category:  0,
        radionuclides: [
            { name: 'Fr-222', exemption_level: 10**5, t_medium: nil },
            { name: 'Fr-223', exemption_level: 10**6, t_medium: nil },
        ]
      },
      { short: 'Ra', long: 'Radium',       mass: 226.0254,  category:  1,
        radionuclides: [
            { name: 'Ra-223', exemption_level: 10**5, t_medium: nil },
            { name: 'Ra-224', exemption_level: 10**5, t_medium: nil },
            { name: 'Ra-225', exemption_level: 10**5, t_medium: nil },
            { name: 'Ra-226', exemption_level: 10**4, t_medium: nil },
            { name: 'Ra-227', exemption_level: 10**6, t_medium: nil },
            { name: 'Ra-228', exemption_level: 10**5, t_medium: nil },
        ]
      },

      { short: 'Ac', long: 'Actinium',     mass: 227.0278,  category:  9,
        radionuclides: [
            { name: 'Ac-224', exemption_level: 10**6, t_medium: nil },
            { name: 'Ac-225', exemption_level: 10**4, t_medium: nil },
            { name: 'Ac-226', exemption_level: 10**5, t_medium: nil },
            { name: 'Ac-227', exemption_level: 10**3, t_medium: nil },
            { name: 'Ac-228', exemption_level: 10**6, t_medium: nil },
        ]
      },
      { short: 'Th', long: 'Thorium',      mass: 232.0381,  category:  9,
        radionuclides: [
            { name: 'Th-226', exemption_level: 10**7, t_medium: nil },
            { name: 'Th-227', exemption_level: 10**4, t_medium: nil },
            { name: 'Th-228', exemption_level: 10**4, t_medium: nil },
            { name: 'Th-229', exemption_level: 10**3, t_medium: nil },
            { name: 'Th-230', exemption_level: 10**4, t_medium: nil },
            { name: 'Th-231', exemption_level: 10**7, t_medium: nil },
            { name: 'Th-232', exemption_level: 10**4, t_medium: nil },
            { name: 'Th-234', exemption_level: 10**5, t_medium: nil },
        ]
      },   # 90
      { short: 'Pa', long: 'Protactinium', mass: 231.03588, category:  9,
        radionuclides: [
            { name: 'Pa-227', exemption_level: 10**6, t_medium: nil },
            { name: 'Pa-228', exemption_level: 10**6, t_medium: nil },
            { name: 'Pa-230', exemption_level: 10**6, t_medium: nil },
            { name: 'Pa-231', exemption_level: 10**3, t_medium: nil },
            { name: 'Pa-232', exemption_level: 10**6, t_medium: nil },
            { name: 'Pa-233', exemption_level: 10**7, t_medium: nil },
            { name: 'Pa-234', exemption_level: 10**6, t_medium: nil },
        ]
      },
      { short: 'U',  long: 'Uranium',      mass: 238.0289,  category:  9,
        radionuclides: [
            { name: 'U-230', exemption_level: 10**5, t_medium: nil },
            { name: 'U-231', exemption_level: 10**7, t_medium: nil },
            { name: 'U-232', exemption_level: 10**3, t_medium: nil },
            { name: 'U-233', exemption_level: 10**4, t_medium: nil },
            { name: 'U-234', exemption_level: 10**4, t_medium: nil },
            { name: 'U-235', exemption_level: 10**4, t_medium: nil },
            { name: 'U-236', exemption_level: 10**4, t_medium: nil },
            { name: 'U-237', exemption_level: 10**6, t_medium: nil },
            { name: 'U-238', exemption_level: 10**4, t_medium: nil },
            { name: 'U-239', exemption_level: 10**6, t_medium: nil },
            { name: 'U-240', exemption_level: 10**7, t_medium: nil },
            { name: 'U-240', exemption_level: 10**6, t_medium: nil },
        ]
      },
      { short: 'Np', long: 'Neptunium',    mass: 237.0482,  category:  9,
        radionuclides: [
            { name: 'Np-232', exemption_level: 10**6, t_medium: nil },
            { name: 'Np-233', exemption_level: 10**7, t_medium: nil },
            { name: 'Np-234', exemption_level: 10**6, t_medium: nil },
            { name: 'Np-235', exemption_level: 10**7, t_medium: nil },
            { name: 'Np-236', exemption_level: 10**5, t_medium: nil },
            { name: 'Np-236m', exemption_level: 10**7, t_medium: nil },
            { name: 'Np-237', exemption_level: 10**3, t_medium: nil },
            { name: 'Np-238', exemption_level: 10**6, t_medium: nil },
            { name: 'Np-239', exemption_level: 10**7, t_medium: nil },
            { name: 'Np-240', exemption_level: 10**6, t_medium: nil },
        ]
      },
      { short: 'Pu', long: 'Plutonium',    mass: 244.0642,  category:  9,
        radionuclides: [
            { name: 'Pu-234', exemption_level: 10**7, t_medium: nil },
            { name: 'Pu-235', exemption_level: 10**7, t_medium: nil },
            { name: 'Pu-236', exemption_level: 10**4, t_medium: nil },
            { name: 'Pu-237', exemption_level: 10**7, t_medium: nil },
            { name: 'Pu-238', exemption_level: 10**4, t_medium: nil },
            { name: 'Pu-239', exemption_level: 10**4, t_medium: nil },
            { name: 'Pu-240', exemption_level: 10**3, t_medium: nil },
            { name: 'Pu-241', exemption_level: 10**5, t_medium: nil },
            { name: 'Pu-242', exemption_level: 10**4, t_medium: nil },
            { name: 'Pu-243', exemption_level: 10**7, t_medium: nil },
            { name: 'Pu-244', exemption_level: 10**4, t_medium: nil },
            { name: 'Pu-245', exemption_level: 10**6, t_medium: nil },
            { name: 'Pu-246', exemption_level: 10**6, t_medium: nil },
        ]
      },
      { short: 'Am', long: 'Americium',    mass: 243.0614,  category:  9,
        radionuclides: [
            { name: 'Am-237', exemption_level: 10**6, t_medium: nil },
            { name: 'Am-238', exemption_level: 10**6, t_medium: nil },
            { name: 'Am-239', exemption_level: 10**6, t_medium: nil },
            { name: 'Am-240', exemption_level: 10**6, t_medium: nil },
            { name: 'Am-241', exemption_level: 10**4, t_medium: nil },
            { name: 'Am-242', exemption_level: 10**6, t_medium: nil },
            { name: 'Am-242m', exemption_level: 10**4, t_medium: nil },
            { name: 'Am-243', exemption_level: 10**3, t_medium: nil },
            { name: 'Am-244', exemption_level: 10**6, t_medium: nil },
            { name: 'Am-244m', exemption_level: 10**7, t_medium: nil },
            { name: 'Am-245', exemption_level: 10**6, t_medium: nil },
            { name: 'Am-246', exemption_level: 10**5, t_medium: nil },
            { name: 'Am-246m', exemption_level: 10**6, t_medium: nil },
        ]
      },
      { short: 'Cm', long: 'Curium',       mass: 247.0703,  category:  9,
        radionuclides: [
            { name: 'Cm-238', exemption_level: 10**7, t_medium: nil },
            { name: 'Cm-240', exemption_level: 10**5, t_medium: nil },
            { name: 'Cm-241', exemption_level: 10**6, t_medium: nil },
            { name: 'Cm-242', exemption_level: 10**5, t_medium: nil },
            { name: 'Cm-243', exemption_level: 10**4, t_medium: nil },
            { name: 'Cm-244', exemption_level: 10**4, t_medium: nil },
            { name: 'Cm-245', exemption_level: 10**3, t_medium: nil },
            { name: 'Cm-246', exemption_level: 10**3, t_medium: nil },
            { name: 'Cm-247', exemption_level: 10**4, t_medium: nil },
            { name: 'Cm-248', exemption_level: 10**3, t_medium: nil },
            { name: 'Cm-249', exemption_level: 10**6, t_medium: nil },
            { name: 'Cm-250', exemption_level: 10**3, t_medium: nil },
        ]
      },
      { short: 'Bk', long: 'Berkelium',    mass: 247.0703,  category:  9,
        radionuclides: [
            { name: 'Bk-245', exemption_level: 10**6, t_medium: nil },
            { name: 'Bk-246', exemption_level: 10**6, t_medium: nil },
            { name: 'Bk-247', exemption_level: 10**4, t_medium: nil },
            { name: 'Bk-249', exemption_level: 10**6, t_medium: nil },
            { name: 'Bk-250', exemption_level: 10**6, t_medium: nil },
        ]
      },
      { short: 'Cf', long: 'Californium',  mass: 251.0796,  category:  9,
        radionuclides: [
            { name: 'Cf-244', exemption_level: 10**7, t_medium: nil },
            { name: 'Cf-246', exemption_level: 10**6, t_medium: nil },
            { name: 'Cf-248', exemption_level: 10**4, t_medium: nil },
            { name: 'Cf-249', exemption_level: 10**3, t_medium: nil },
            { name: 'Cf-250', exemption_level: 10**4, t_medium: nil },
            { name: 'Cf-251', exemption_level: 10**3, t_medium: nil },
            { name: 'Cf-252', exemption_level: 10**4, t_medium: nil },
            { name: 'Cf-253', exemption_level: 10**5, t_medium: nil },
            { name: 'Cf-254', exemption_level: 10**3, t_medium: nil },
        ]
      },
      { short: 'Es', long: 'Einsteinium',  mass: 254,       category:  9,
        radionuclides: [
            { name: 'Es-250', exemption_level: 10**6, t_medium: nil },
            { name: 'Es-251', exemption_level: 10**7, t_medium: nil },
            { name: 'Es-253', exemption_level: 10**5, t_medium: nil },
            { name: 'Es-254', exemption_level: 10**4, t_medium: nil },
            { name: 'Es-254m', exemption_level: 10**6, t_medium: nil },
        ]
      },
      { short: 'Fm', long: 'Fermium',      mass: 257.0951,  category:  9,
        radionuclides: [
            { name: 'Fm-252', exemption_level: 10**6, t_medium: nil },
            { name: 'Fm-253', exemption_level: 10**6, t_medium: nil },
            { name: 'Fm-254', exemption_level: 10**7, t_medium: nil },
            { name: 'Fm-255', exemption_level: 10**6, t_medium: nil },
            { name: 'Fm-257', exemption_level: 10**5, t_medium: nil },
        ]
      },   # 100
      { short: 'Md', long: 'Mendelevium',  mass: 258.1,     category:  9,
        radionuclides: [
            { name: 'Md-257', exemption_level: 10**7, t_medium: nil },
            { name: 'Md-258', exemption_level: 10**5, t_medium: nil },
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

  # TODO: Remove these methods
  def years(amount)
    amount*365
  end

  def hours(amount)
    amount/24
  end

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
