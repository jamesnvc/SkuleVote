class CreateVoters < ActiveRecord::Migration
  def self.up
    create_table :voters do |t|
    end
    
    create_table :elections_voters, :id => false do |t|
	t.integer :election_id
	t.integer :voter_id
    end
  end

  def self.down
    drop_table :voters
    drop_table :elections_voters
  end
end
