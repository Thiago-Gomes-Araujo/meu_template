json.extract! endereco, :id, :descricao, :rua, :cidade, :estado, :cep, :cliente_id, :funcionario_id, :endereco_principal, :created_at, :updated_at
json.url endereco_url(endereco, format: :json)
