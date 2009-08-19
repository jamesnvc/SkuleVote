class CreateVotes < ActiveRecord::Migration
  def self.up
    create_table :votes do |t|
      t.integer :election_id
      t.integer :choice_id
      t.integer :ballot_id
      t.integer :result
    end
  end

  def self.down
    drop_table :votes
  end
end
