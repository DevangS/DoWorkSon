class Chore < ActiveRecord::Base
  belongs_to :currentPerson
  has_many :people
  attr_accessible :description, :friday, :monday, :name, :saturday, :startDate, :sunday, :thursday, :time, :tuesday, :wednesday
end
