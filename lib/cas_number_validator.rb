class CasNumberValidator < ActiveModel::EachValidator
  def validate_each(record,attribute,value)
    cas, num0, num1, control = value.match(/(\d{2,7})\-(\d\d)\-(\d)/).to_a
    unless cas
      record.errors[attribute] << (options[:message] || "format is invalid")
      return
    end
    num = (num0+num1).reverse.scan(/\d/).each_with_index.map {|n, i| n.to_i*(i+1) }.sum

    record.errors[attribute] << (options[:message] || "is invalid cas number") unless num % 10 == control.to_i
  end
end