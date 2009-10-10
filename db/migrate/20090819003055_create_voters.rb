class CreateVoters < ActiveRecord::Migration
  def self.up
    create_table :voters do |t|
      t.string :sid, :null => false
      t.string :persistence_token, :null => false 
       
     # t.integer :login_count, :default => 0, :null => false
     # t.datetime :last_request_at
     # t.datetime :last_login_at
     # t.datetime :current_login_at
     # t.string :last_login_ip
     # t.string :current_login_ip
     
      t.boolean :student, :null => false
      t.boolean :registered, :null => false
      t.boolean :undergrad, :null => false
      t.string :org, :null => false
      t.string :campus, :null => false
	  t.string :attendance, :null => false
	  t.integer :year, :null => false
      t.string :discipline, :null => false
      t.boolean :pey, :null => false
    end
    
    add_index :voters, :sid
    add_index :voters, :persistence_token
   # add_index :voters, :last_request_at
    
    create_table :elections_voters, :id => false do |t|
      t.integer :election_id
      t.integer :voter_id
    end
    
    add_index :elections_voters, :election_id
    add_index :elections_voters, :voter_id
  end

  def self.down
    drop_table :voters
    drop_table :elections_voters
  end
end
