class CreateBallots < ActiveRecord::Migration
  def self.up
    create_table :ballots do |t|
      t.integer :election_id

      t.datetime :created_at
    end
    
    add_index :ballots, :election_id
  end
  
  def self.down
    drop_table :ballots
  end
end
