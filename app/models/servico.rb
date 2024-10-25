class Servico < ApplicationRecord

  has_many :atendimento_servicos, dependent: :destroy
  has_many :atendimentos, through: :atendimento_servicos

  def to_s
    descricao
  end

  def self.ransackable_attributes(auth_object = nil)
    ["titulo", "descricao", "valor", "created_at", "updated_at"]
  end
end
