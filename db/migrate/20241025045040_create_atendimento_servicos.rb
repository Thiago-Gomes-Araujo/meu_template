class CreateAtendimentoServicos < ActiveRecord::Migration[7.2]
  def change
    create_table :atendimento_servicos do |t|
      t.references :atendimento, null: false, foreign_key: true
      t.references :servico, null: false, foreign_key: true

      t.timestamps
    end
  end
end
