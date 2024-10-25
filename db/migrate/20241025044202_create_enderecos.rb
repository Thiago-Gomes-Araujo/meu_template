class CreateEnderecos < ActiveRecord::Migration[7.2]
  def change
    create_table :enderecos do |t|
      t.string :descricao
      t.string :rua
      t.string :cidade
      t.string :estado
      t.string :cep
      t.references :cliente, null: false, foreign_key: true
      t.references :funcionario, null: false, foreign_key: true
      t.boolean :endereco_principal

      t.timestamps
    end
  end
end
