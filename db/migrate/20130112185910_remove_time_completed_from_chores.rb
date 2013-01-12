class RemoveTimeCompletedFromChores < ActiveRecord::Migration
  def up
      
      remove_column :chores, :time_reminded
  end

  def down
      add_column :chores, :time_reminded, :time
  end
end
