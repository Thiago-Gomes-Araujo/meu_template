class CreateAvaliacaos < ActiveRecord::Migration[7.2]
  def change
    create_table :avaliacaos do |t|
      t.references :cliente, null: false, foreign_key: true
      t.integer :nota
      t.date :data
      t.text :comentario

      t.timestamps
    end
  end
end
