class CreateServicos < ActiveRecord::Migration[7.2]
  def change
    create_table :servicos do |t|
      t.string :titulo
      t.text :descricao
      t.decimal :tempodeatendimento
      t.decimal :valor

      t.timestamps
    end
  end
end
