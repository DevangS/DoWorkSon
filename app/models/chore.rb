class Chore < ActiveRecord::Base
  belongs_to :currentPerson, :class_name => "person"
  has_many :people, :class_name => "person", :dependent => :destroy
  accepts_nested_attributes_for :people
  attr_accessible :description, :friday, :monday, :name, :saturday, :startDate, :sunday, :thursday, :time, :tuesday, :wednesday
end
