# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.2].define(version: 2024_10_25_051228) do
  create_table "atendimento_servicos", force: :cascade do |t|
    t.integer "atendimento_id", null: false
    t.integer "servico_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["atendimento_id"], name: "index_atendimento_servicos_on_atendimento_id"
    t.index ["servico_id"], name: "index_atendimento_servicos_on_servico_id"
  end

  create_table "atendimentos", force: :cascade do |t|
    t.datetime "data_inicio"
    t.integer "status_agendamento_id", null: false
    t.integer "cliente_id", null: false
    t.integer "endereco_id", null: false
    t.integer "funcionario_id", null: false
    t.datetime "data_fim"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cliente_id"], name: "index_atendimentos_on_cliente_id"
    t.index ["endereco_id"], name: "index_atendimentos_on_endereco_id"
    t.index ["funcionario_id"], name: "index_atendimentos_on_funcionario_id"
    t.index ["status_agendamento_id"], name: "index_atendimentos_on_status_agendamento_id"
  end

  create_table "avaliacaos", force: :cascade do |t|
    t.integer "cliente_id", null: false
    t.integer "nota"
    t.date "data"
    t.text "comentario"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cliente_id"], name: "index_avaliacaos_on_cliente_id"
  end

  create_table "clientes", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "nome"
    t.string "telefone"
    t.integer "endereco_principal"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_clientes_on_user_id"
  end

  create_table "enderecos", force: :cascade do |t|
    t.string "descricao"
    t.string "rua"
    t.string "cidade"
    t.string "estado"
    t.string "cep"
    t.integer "cliente_id", null: false
    t.integer "funcionario_id", null: false
    t.boolean "endereco_principal"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cliente_id"], name: "index_enderecos_on_cliente_id"
    t.index ["funcionario_id"], name: "index_enderecos_on_funcionario_id"
  end

  create_table "funcionarios", force: :cascade do |t|
    t.string "nome"
    t.string "telefone"
    t.string "cargo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "servicos", force: :cascade do |t|
    t.string "titulo"
    t.text "descricao"
    t.decimal "tempodeatendimento"
    t.decimal "valor"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "status_agendamentos", force: :cascade do |t|
    t.string "descricao"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "role"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "atendimento_servicos", "atendimentos"
  add_foreign_key "atendimento_servicos", "servicos"
  add_foreign_key "atendimentos", "clientes"
  add_foreign_key "atendimentos", "enderecos"
  add_foreign_key "atendimentos", "funcionarios"
  add_foreign_key "atendimentos", "status_agendamentos"
  add_foreign_key "avaliacaos", "clientes"
  add_foreign_key "clientes", "users"
  add_foreign_key "enderecos", "clientes"
  add_foreign_key "enderecos", "funcionarios"
end
