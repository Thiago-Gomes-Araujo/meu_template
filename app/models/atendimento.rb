class Atendimento < ApplicationRecord
  belongs_to :status_agendamento
  belongs_to :cliente
  belongs_to :endereco, optional: true
  belongs_to :funcionario, optional: true  

  has_many :atendimento_servicos, dependent: :destroy
  has_many :servicos, through: :atendimento_servicos

  # Definir o status padrão ao inicializar uma nova instância
  after_initialize :set_default_status, if: :new_record?

  validates :endereco_id, presence: { message: "is mandatory. Select an address." }
  validates :servicos, presence: { message: "It is mandatory to select at least one service." }

  def self.ransackable_attributes(auth_object = nil)
    ["cliente_id", "funcionario_id", "data_inicio", "data_fim", "status_agendamento_id"] # Inclua o ID das associações
  end

  def self.ransackable_associations(auth_object = nil)
    ["cliente", "funcionario", "status_agendamento", "servicos"]  # Adicione associações que deseja permitir a pesquisa
  end

  def cliente_nome
    cliente&.nome
  end

  private

  def set_default_status
    # Busque o status com a descrição 'Pending' e defina como o status padrão
    self.status_agendamento ||= StatusAgendamento.find_by(descricao: 'Pending')
  end
end
