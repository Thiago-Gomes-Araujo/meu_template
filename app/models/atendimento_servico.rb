class AtendimentoServico < ApplicationRecord
  belongs_to :atendimento
  belongs_to :servico
end
