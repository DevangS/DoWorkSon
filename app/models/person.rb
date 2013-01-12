class EmailValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors.add attribute, (options[:message] || "is not an email") unless
      value =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  end
end

class PhoneValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors.add attribute, (options[:message] || "is not a valid 10 digit phone number (e.g. 5556667777)") unless
      value =~ /\A[0-9]{10}\Z/i
  end
end

class Person < ActiveRecord::Base
  belongs_to :chore
  attr_accessible :email, :name, :order, :phone
  
  validates :email,  :email => true
  validates :phone, :phone => true
  

end
