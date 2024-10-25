class Cliente < ApplicationRecord
  belongs_to :user
  has_many :enderecos, dependent: :destroy 
  accepts_nested_attributes_for :enderecos, allow_destroy: true
  has_many :avaliacaos, dependent: :destroy 

  validates :nome, :telefone, presence: true

  def to_s
    nome
  end

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "endereco_principal", "id", "nome", "telefone", "updated_at", "user_id"]
  end
end
