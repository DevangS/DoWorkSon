class Chore < ActiveRecord::Base
  belongs_to :currentPerson, :class_name => "person"
  has_many :people, :dependent => :destroy
  accepts_nested_attributes_for :people, allow_destroy: true
  attr_accessible :people_attributes,:time_reminded,:time_completed, :description, :friday, :monday, :name, :saturday, :start_date, :sunday, :thursday, :time, :tuesday, :wednesday
  
  validates :name, :length => { :maximum =>30 }
  validate :one_day_must_be_set

def one_day_must_be_set
  unless monday || tuesday || wednesday || thursday || friday || saturday || sunday
    errors.add(:base, "Sup with not setting a day of the week, bro?")
  end
end

  
  def opt_out_current
      #remove current person and set chore to next person
      person = self.currentPerson
      self.to_next_person
      person.destroy
      
  end
  
  def update_shift
      list = self.people.all.order_by :order
      n=false
      list.each do |p|
          if n == true
              currentPerson = p
              return
          end
          if p.id == currentPerson.id
              n =true
          end
      end
      currentPerson = list.first
      return
  end
  
  def self.find_chores  
      t= Time.now
      day = t.strftime('%A').downcase
      hours_ago = t - 12.hours
      pre_time = Time.gm(2000,1,1,0,0,0) + t.min.minutes + t.sec.seconds - 1.hour
      chores = Chore.where(day+" AND time_completed < ? and time > ? AND start_date >= ?",hours_ago,pre_time,t)
      

  end
                      
  def self.find_lazy_chores
                      
  end

end
