class Chore < ActiveRecord::Base
  belongs_to :currentPerson
  attr_accessible :description, :friday, :monday, :name, :saturday, :startDate, :sunday, :thursday, :time, :tuesday, :wednesday
end
