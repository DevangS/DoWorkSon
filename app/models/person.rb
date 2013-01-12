class Person < ActiveRecord::Base
  belongs_to :chore
  attr_accessible :email, :name, :order, :phone
end
