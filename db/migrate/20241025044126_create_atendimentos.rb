class CreateAtendimentos < ActiveRecord::Migration[7.2]
  def change
    create_table :atendimentos do |t|
      t.datetime :data_inicio
      t.references :status_agendamento, null: false, foreign_key: true
      t.references :cliente, null: false, foreign_key: true
      t.references :endereco, null: false, foreign_key: true
      t.references :funcionario, null: false, foreign_key: true
      t.datetime :data_fim

      t.timestamps
    end
  end
end
