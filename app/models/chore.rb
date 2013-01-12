class Chore < ActiveRecord::Base
  belongs_to :currentPerson, :class_name => "person"
  has_many :people, :dependent => :destroy
  accepts_nested_attributes_for :people, allow_destroy: true
  attr_accessible :currentPerson,:people_attributes,:time_reminded,:time_completed, :description, :friday, :monday, :name, :saturday, :start_date, :sunday, :thursday, :time, :tuesday, :wednesday
  
  validates :name, :length => { :maximum =>30 }
  validate :one_day_must_be_set
  validate :at_least_a_person

  after_initialize :init

    def init
      t= Time.now
      self.name  ||= "A Chore"
      self.time_completed  ||= t -1.day
      self.time_reminded ||= t - 1.day
      self.currentPerson = self.people.first
    end
  
 
    def at_least_a_person
        unless not people.empty?
            errors.add(:base, "Gotta have someone doing the chores")
        end
    end
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
      if people.empty?
          self.destroy
      end
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
      pre_time = Time.gm(2000,1,1,0,0,0) if pre_time<Time.gm(2000,1,1,0,0,1)
      chores = Chore.where(day+" AND (time_completed IS NULL OR time_completed < ?) and time > ? AND start_date >= ?",hours_ago,pre_time,t-1.day)
  end
                      
  def self.find_lazy_chores
      t= Time.now
      day = t.strftime('%A').downcase
      hours_ago = t - 12.hours
      pre_time = Time.gm(2000,1,1,0,0,0) + t.min.minutes + t.sec.seconds + 1.hour
      pre_time = Time.gm(2000,1,1,0,0,0) if pre_time<Time.gm(2000,1,1,0,0,1)
      chores = Chore.where(day+" AND (time_completed IS NULL OR time_completed > ?) and time > ? AND start_date >= ?",hours_ago+ 23.hours,pre_time,t-1.day)
  end

end
