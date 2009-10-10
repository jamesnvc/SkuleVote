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
      t.integer :max_choices
      t.integer :min_choices
      t.boolean :random

      t.timestamps
    end
    
    add_index :elections, :start
    add_index :elections, :end
    add_index :elections, :eligible_year
    add_index :elections, :eligible_discipline
  end

  def self.down
    drop_table :elections
  end
end
