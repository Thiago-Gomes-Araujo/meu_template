class Avaliacao < ApplicationRecord
  belongs_to :cliente
  validates :nota, presence: true
  validates :comentario, presence: true
end
