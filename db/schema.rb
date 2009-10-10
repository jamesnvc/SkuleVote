# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20090819003055) do

  create_table "ballots", :force => true do |t|
    t.integer  "election_id"
    t.datetime "created_at"
  end

  add_index "ballots", ["election_id"], :name => "index_ballots_on_election_id"

  create_table "choices", :force => true do |t|
    t.integer "election_id"
    t.string  "name"
    t.text    "description"
  end

  add_index "choices", ["election_id"], :name => "index_choices_on_election_id"

  create_table "elections", :force => true do |t|
    t.string   "name"
    t.text     "blurb"
    t.datetime "start"
    t.datetime "end"
    t.integer  "eligible_year"
    t.string   "eligible_discipline"
    t.boolean  "preferential"
    t.integer  "max_choices"
    t.integer  "min_choices"
    t.boolean  "random"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "elections", ["eligible_discipline"], :name => "index_elections_on_eligible_discipline"
  add_index "elections", ["eligible_year"], :name => "index_elections_on_eligible_year"
  add_index "elections", ["end"], :name => "index_elections_on_end"
  add_index "elections", ["start"], :name => "index_elections_on_start"

  create_table "elections_voters", :id => false, :force => true do |t|
    t.integer "election_id"
    t.integer "voter_id"
  end

  add_index "elections_voters", ["election_id"], :name => "index_elections_voters_on_election_id"
  add_index "elections_voters", ["voter_id"], :name => "index_elections_voters_on_voter_id"

  create_table "voters", :force => true do |t|
    t.string  "sid",               :null => false
    t.string  "persistence_token", :null => false
    t.boolean "student",           :null => false
    t.boolean "registered",        :null => false
    t.boolean "undergrad",         :null => false
    t.string  "org",               :null => false
    t.string  "campus",            :null => false
    t.string  "attendance",        :null => false
    t.integer "year",              :null => false
    t.string  "discipline",        :null => false
    t.boolean "pey",               :null => false
  end

  add_index "voters", ["persistence_token"], :name => "index_voters_on_persistence_token"
  add_index "voters", ["sid"], :name => "index_voters_on_sid"

  create_table "votes", :force => true do |t|
    t.integer "election_id"
    t.integer "choice_id"
    t.integer "ballot_id"
    t.integer "result"
  end

  add_index "votes", ["ballot_id"], :name => "index_votes_on_ballot_id"
  add_index "votes", ["choice_id"], :name => "index_votes_on_choice_id"
  add_index "votes", ["election_id"], :name => "index_votes_on_election_id"

end
