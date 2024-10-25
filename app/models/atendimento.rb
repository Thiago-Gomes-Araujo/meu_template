class Atendimento < ApplicationRecord
  belongs_to :status_agendamento
  belongs_to :cliente
  belongs_to :endereco
  belongs_to :funcionario
end
