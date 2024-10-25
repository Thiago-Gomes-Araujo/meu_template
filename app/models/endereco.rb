class Endereco < ApplicationRecord
  belongs_to :cliente, optional: true
  belongs_to :funcionario, optional: true

  validates :descricao, presence: true, length: { maximum: 255 }
  validates :rua, presence: true, length: { maximum: 255 }
  validates :cidade, presence: true, length: { maximum: 255 }
  validates :estado, presence: true, length: { maximum: 255 }
  validates :cep, presence: true, format: { with: /\A\d{5}-\d{3}\z/, message: "deve estar no formato 12345-678" } # Ajuste o regex conforme necessário
  validates :cliente_id, presence: true
  # validates :endereco_principal, inclusion: { in: [true, false] }

  def to_s
    descricao
  end
  def self.ransackable_attributes(auth_object = nil)
    ["cep", "cidade", "cliente_id", "created_at", "descricao", "endereco_principal", "estado", "funcionario_id", "id", "id_value", "rua", "updated_at"]
  end
  def self.ransackable_associations(auth_object = nil)
    ["cliente", "funcionario"]
  end
end
