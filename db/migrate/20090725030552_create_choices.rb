class CreateChoices < ActiveRecord::Migration
  def self.up
    create_table :choices do |t|
      t.integer :election_id
      t.string :name
    end
  end

  def self.down
    drop_table :choices
  end
end
