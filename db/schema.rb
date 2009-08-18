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

ActiveRecord::Schema.define(:version => 20090725030616) do

  create_table "ballots", :force => true do |t|
    t.integer  "sp_id"
    t.integer  "election_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "choices", :force => true do |t|
    t.integer  "election_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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

  create_table "votes", :force => true do |t|
    t.integer  "election_id"
    t.integer  "choice_id"
    t.integer  "result"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
