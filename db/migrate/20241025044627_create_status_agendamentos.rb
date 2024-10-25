class CreateStatusAgendamentos < ActiveRecord::Migration[7.2]
  def change
    create_table :status_agendamentos do |t|
      t.string :descricao

      t.timestamps
    end
  end
end
