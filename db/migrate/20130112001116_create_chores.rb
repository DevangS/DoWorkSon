class CreateChores < ActiveRecord::Migration
  def change
    create_table :chores do |t|
      t.string :name
      t.time :time
      t.date :startDate
      t.boolean :monday
      t.boolean :tuesday
      t.boolean :wednesday
      t.boolean :thursday
      t.boolean :friday
      t.boolean :saturday
      t.boolean :sunday
      t.references :currentPerson
      t.text :description

      t.timestamps
    end
    add_index :chores, :currentPerson_id
  end
end
