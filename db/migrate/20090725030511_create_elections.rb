class CreateElections < ActiveRecord::Migration
  def self.up
    create_table :elections do |t|
      t.string :name
      t.text :blurb
      t.datetime :start
      t.datetime :end
      t.integer :eligible_year
      t.string :eligible_discipline
      t.boolean :preferential

      t.timestamps
    end
  end

  def self.down
    drop_table :elections
  end
end
