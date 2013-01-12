class RemoveTimeRemindedFromChores < ActiveRecord::Migration
  def up
      remove_column :chores, :time_completed
  end

  def down
      add_column :chores, :time_completed, :time
  end
end
