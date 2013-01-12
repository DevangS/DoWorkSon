class AddTimeCompletedFromChores < ActiveRecord::Migration
  def change
    add_column :chores, :time_completed, :datetime
  end
end
