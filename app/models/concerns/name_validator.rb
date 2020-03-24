class NameValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value == value.titleize
      record.errors[attribute] << 'Name has to start from capital letter'
    end
  end
end