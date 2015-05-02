require 'spec_helper'

describe ChemistryRails do
  it "should return elements" do
    expect(ChemistryRails.elements).to be_a(Array)
    expect(ChemistryRails.elements.length).to be > 0
    expect(ChemistryRails.elements(1)).to be_a(Array)
    expect(ChemistryRails.elements(-1)).to eq []
  end

  it "should return an element" do
    expect(ChemistryRails.element('O')).to be_a(Hash)
    expect(ChemistryRails.element('O')).to have_key(:short)
    expect(ChemistryRails.element('O')).to have_key(:long)
    expect(ChemistryRails.element('O')).to have_key(:mass)
    expect(ChemistryRails.element('O')).to have_key(:category)
  end

end

describe ChemistryRails::Formula do

  it "creates a new obj and processes the formula" do
    formula = ChemistryRails::Formula.new('C6H6')
    expect(formula.elements).to be_a(Hash)
    expect(formula.elements).to have_key('C')
    expect(formula.elements).to have_key('H')
    expect(formula.elements['C']).to eq(6)
    expect(formula.elements['H']).to eq(6)
  end

  it "generates an html string for the formula" do
    formula = ChemistryRails::Formula.new('C6H6')
    expect(formula.to_html).to include('<sub>')
    expect(formula.to_html).to eq('C<sub>6</sub>H<sub>6</sub>')
  end

  it "calculates elemental analysis" do
    formula = ChemistryRails::Formula.new('C2H6O')
    expect(formula.elemental_analysis).to be_a(Hash)
    expect(formula.elemental_analysis['C']).to eq(52.14)
    expect(formula.elemental_analysis['H']).to eq(13.13)
    expect(formula.elemental_analysis).not_to have_key('O')
  end

  it "validates elements" do
    formula = ChemistryRails::Formula.new('C6H6')
    expect(formula.valid_elements?).to eq(true)
    expect(formula.elemental_analysis).to be_a(Hash)
    formula = ChemistryRails::Formula.new('C6H6D')
    expect(formula.valid_elements?).to eq(false)
    expect(formula.elemental_analysis).to be_a(Hash)
  end
end