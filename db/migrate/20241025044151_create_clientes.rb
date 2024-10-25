class CreateClientes < ActiveRecord::Migration[7.2]
  def change
    create_table :clientes do |t|
      t.references :user, null: false, foreign_key: true
      t.string :nome
      t.string :telefone
      t.integer :endereco_principal

      t.timestamps
    end
  end
end
