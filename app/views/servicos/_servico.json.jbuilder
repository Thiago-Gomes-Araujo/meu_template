json.extract! servico, :id, :titulo, :descricao, :tempodeatendimento, :valor, :created_at, :updated_at
json.url servico_url(servico, format: :json)
