class RenameStartDate < ActiveRecord::Migration
  def up
      rename_column :chores, :startDate, :start_date
  end

  def down
      rename_column :chores, :start_date, :startDate
  end
end
