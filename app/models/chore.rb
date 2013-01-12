class Chore < ActiveRecord::Base
  belongs_to :currentPerson, :class_name => "person"
  has_many :people, :dependent => :destroy
  accepts_nested_attributes_for :people, allow_destroy: true
  attr_accessible :people_attributes, :description, :friday, :monday, :name, :saturday, :startDate, :sunday, :thursday, :time, :tuesday, :wednesday
end
