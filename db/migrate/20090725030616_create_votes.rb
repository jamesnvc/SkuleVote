class CreateVotes < ActiveRecord::Migration
  def self.up
    create_table :votes do |t|
      t.integer :election_id
      t.integer :choice_id
      t.integer :ballot_id
      t.integer :result
    end
    
    add_index :votes, :election_id
    add_index :votes, :choice_id
    add_index :votes, :ballot_id
  end
  

  def self.down
    drop_table :votes
  end
end
