class Funcionario < ApplicationRecord
  has_many :atendimentos

  validates :nome, :telefone, presence: true
  def self.ransackable_attributes(auth_object = nil)
    ["cargo", "created_at", "id", "nome", "telefone", "updated_at"]
  end
  
  def to_s
    nome
  end
  
end
