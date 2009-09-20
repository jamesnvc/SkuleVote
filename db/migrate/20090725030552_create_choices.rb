class CreateChoices < ActiveRecord::Migration
  def self.up
    create_table :choices do |t|
      t.integer :election_id
      t.string :name
      t.text :description
    end
    
    add_index :choices, :election_id
  end

  def self.down
    drop_table :choices
  end
end
