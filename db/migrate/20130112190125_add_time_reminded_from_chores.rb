class AddTimeRemindedFromChores < ActiveRecord::Migration
  def change

    add_column :chores, :time_reminded, :datetime
  end
end
