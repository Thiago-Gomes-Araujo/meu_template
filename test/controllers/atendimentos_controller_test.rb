require "test_helper"

class AtendimentosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @atendimento = atendimentos(:one)
  end

  test "should get index" do
    get atendimentos_url
    assert_response :success
  end

  test "should get new" do
    get new_atendimento_url
    assert_response :success
  end

  test "should create atendimento" do
    assert_difference("Atendimento.count") do
      post atendimentos_url, params: { atendimento: { cliente_id: @atendimento.cliente_id, data_fim: @atendimento.data_fim, data_inicio: @atendimento.data_inicio, endereco_id: @atendimento.endereco_id, funcionario_id: @atendimento.funcionario_id, status_agendamento_id: @atendimento.status_agendamento_id } }
    end

    assert_redirected_to atendimento_url(Atendimento.last)
  end

  test "should show atendimento" do
    get atendimento_url(@atendimento)
    assert_response :success
  end

  test "should get edit" do
    get edit_atendimento_url(@atendimento)
    assert_response :success
  end

  test "should update atendimento" do
    patch atendimento_url(@atendimento), params: { atendimento: { cliente_id: @atendimento.cliente_id, data_fim: @atendimento.data_fim, data_inicio: @atendimento.data_inicio, endereco_id: @atendimento.endereco_id, funcionario_id: @atendimento.funcionario_id, status_agendamento_id: @atendimento.status_agendamento_id } }
    assert_redirected_to atendimento_url(@atendimento)
  end

  test "should destroy atendimento" do
    assert_difference("Atendimento.count", -1) do
      delete atendimento_url(@atendimento)
    end

    assert_redirected_to atendimentos_url
  end
end
