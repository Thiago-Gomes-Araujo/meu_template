class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :cliente, dependent: :destroy
  has_one :funcionario, dependent: :destroy

  enum role: { user: 0, admin: 1 }

  attr_accessor :nome, :telefone  # Adicione isto

  # Callback para criar um cliente automaticamente
  after_create :create_cliente

  def to_s
    email
  end

  private

  def create_cliente
    # Use build_cliente para associar o cliente ao usuário
    self.build_cliente(nome: self.nome, telefone: self.telefone) 
    self.cliente.save  # Salva o cliente
  end
end
