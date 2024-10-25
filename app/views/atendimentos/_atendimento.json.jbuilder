json.extract! atendimento, :id, :data_inicio, :status_agendamento_id, :cliente_id, :endereco_id, :funcionario_id, :data_fim, :created_at, :updated_at
json.url atendimento_url(atendimento, format: :json)
