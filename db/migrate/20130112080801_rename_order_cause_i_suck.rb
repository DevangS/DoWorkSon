class RenameOrderCauseISuck < ActiveRecord::Migration
  def up
      rename_column :people, :order, :ordering_number
  end

  def down
      rename_column :people, :ordering_number, :order
  end
end
