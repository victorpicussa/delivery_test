# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_05_05_234242) do

  create_table "deliveries", force: :cascade do |t|
    t.string "externalCode"
    t.integer "storeId"
    t.string "subTotal"
    t.string "deliveryFee"
    t.float "total_shipping"
    t.string "total"
    t.string "country"
    t.string "state"
    t.string "city"
    t.string "district"
    t.string "street"
    t.string "complement"
    t.float "latitude"
    t.float "longitude"
    t.string "dtOrderCreate"
    t.string "postalCode"
    t.string "number"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.json "customer"
    t.json "items"
    t.json "payments"
  end

end
