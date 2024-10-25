json.extract! cliente, :id, :user_id, :nome, :telefone, :endereco_principal, :created_at, :updated_at
json.url cliente_url(cliente, format: :json)
