# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_06_22_210542) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "batch_files", force: :cascade do |t|
    t.string "guid"
    t.string "filename"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["guid"], name: "index_batch_files_on_guid"
  end

  create_table "batches", force: :cascade do |t|
    t.integer "batchid"
    t.date "creation_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "batch_file_id"
    t.index ["batch_file_id"], name: "index_batches_on_batch_file_id"
    t.index ["batchid"], name: "index_batches_on_batchid"
  end

  create_table "invoice_datas", force: :cascade do |t|
    t.string "parcel_code"
    t.integer "parcel_price"
    t.integer "item_qty"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "invoice_id"
    t.index ["invoice_id"], name: "index_invoice_datas_on_invoice_id"
    t.index ["parcel_code"], name: "index_invoice_datas_on_parcel_code"
  end

  create_table "invoices", force: :cascade do |t|
    t.integer "operation_number"
    t.date "operation_date"
    t.integer "company_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "batch_id"
    t.index ["batch_id"], name: "index_invoices_on_batch_id"
    t.index ["operation_number"], name: "index_invoices_on_operation_number"
  end

  add_foreign_key "batches", "batch_files"
  add_foreign_key "invoice_datas", "invoices"
  add_foreign_key "invoices", "batches"
end
