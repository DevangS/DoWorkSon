class AddTimeCompletedToChores < ActiveRecord::Migration
  def change
    add_column :chores, :time_completed, :time
  end
end
