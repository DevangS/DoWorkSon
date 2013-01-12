class AddTimeRemindedToChores < ActiveRecord::Migration
  def change
    add_column :chores, :time_reminded, :time
  end
end
