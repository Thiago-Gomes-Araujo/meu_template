class CreateFuncionarios < ActiveRecord::Migration[7.2]
  def change
    create_table :funcionarios do |t|
      t.string :nome
      t.string :telefone
      t.string :cargo

      t.timestamps
    end
  end
end
