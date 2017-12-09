# Chemistry on Rails
===============

A gem for validating chemical formula, calculating elemental analysis and radionuclides data.

## Installation

In Rails, add it to your Gemfile:

```ruby
gem 'chemistry_rails'
```

Finally, restart the server to apply the changes.

## Getting Started

Start off by creating a migration with a string field for the formula (if you don't have it already):

	rails generate migration add_formula_to_chemicals

```ruby
class AddFormulaToChemicals < ActiveRecord::Migration
  def change
    add_column :chemicals, :formula, :string
  end
end
```

Then run the migration to create the field:

	rake db:migrate

Lastly, define the chemical_formula field in the model:

```ruby
class Chemical < ActiveRecord::Base
  chemical_formula :formula
end
```

This will attach the `ChemistryRails::Formula` class to the field and you will be able to use it as described below. An ActiveRecord
validation for chemical formula will be added.

##the Formula class

To initialize a new object you need to pass the chemical formula as a string:

```ruby
formula = ChemistryRails::Formula.new('C6H6')
```

The object has the following properties:

 * `elements` - it will return a Hash with the elements parsed from the formula with the coresponding number of atoms
```
 > formula.elements
  => {"C"=>6, "H"=>6}
```
 * `to_s` - the default ruby to string function - returns the formula as a string
 * `to_html` - it adds \<sub\> tags to the number of atoms, it will return:
```
 > formula.to_html
  => "C<sub>6</sub>H<sub>6</sub>"
```
 > formula.to_rich_text
  => "C₆H₆"
```
 * `elemental_analysis` - it will return Hash with the formula elements with corresponding precent of elemental analysis:
```
 > formula.elemental_analysis
  => {"C"=>92.26, "H"=>7.74}
```

###the ChemistryRails module

the module contains several useful methods:

 * `elements(category=nil)` - it will return all elements in the periodic table with their properties, also it can be filtered
 to return elements form specific category only. You need to provide the category id as integer which corresponds to the index
 of the selected category in the ChemistryRails::ELEMENT_CATEGORIES array. There are also shortcut methods for that below.
 * `element(label)` - returns the properties of a specific element
```
 > ChemistryRails.element('He')
  => {:short=>"He", :long=>"Helium", :mass=>4.0026, :category=>7}
```
 * `alkali_metals`
 * `alkaline_earth`
 * `transition_metals`
 * `basic_metals`
 * `semi_metals`
 * `non_metals`
 * `halogens`
 * `noble_gases`
 * `lanthanides`
 * `actinides`
 * `all_radionuclides`
 * `radionuclides(label)` - returns radionuclides of a specific element
  ```
   > ChemistryRails.radionuclides('Cs')
    => [
         {:name=>"Cs-125", :exemption_level=>10000, :t_medium=>0.03125, :d_value=>nil},
         {:name=>"Cs-127", :exemption_level=>100000, :t_medium=>0.26041666666666663, :d_value=>nil},
         ...
       ] 
  ```
 * `radionuclide(name)` - returns specific radionuclide by name. 
                      Exemption Level(:exemption_level) and D values(:d_value) 
                      for radionuclides are given in Becquerel(Bq) and 
                      T1/2(:t_medium) is given in days
  ```
   > ChemistryRails.radionuclide('Cs-137')
    => {:name=>"Cs-137", :exemption_level=>10000, :t_medium=>10950, :d_value=>(100000000000/1)}
  ```

constants:

 * `ELEMENTS` - used by the `elements` method above. You can use it to get an array of all elements for a dropdown list for example:
```
 > ChemistryRails::ELEMENTS.select{|i| i.present?}.map{|i| i[:short].to_sym}
  => [:H, :He, :Li, :Be, :B, :C, ..... ]
```
 * `ELEMENT_CATEGORIES` - the category id of each element points to this array

## Contributing

We welcome contributions to the repo. Please follow a Github friendly process:

1. Fork the repository on Github
2. Create a named feature branch
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github
