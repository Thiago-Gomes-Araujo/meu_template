require "application_system_test_case"

class AtendimentosTest < ApplicationSystemTestCase
  setup do
    @atendimento = atendimentos(:one)
  end

  test "visiting the index" do
    visit atendimentos_url
    assert_selector "h1", text: "Atendimentos"
  end

  test "should create atendimento" do
    visit atendimentos_url
    click_on "New atendimento"

    fill_in "Cliente", with: @atendimento.cliente_id
    fill_in "Data fim", with: @atendimento.data_fim
    fill_in "Data inicio", with: @atendimento.data_inicio
    fill_in "Endereco", with: @atendimento.endereco_id
    fill_in "Funcionario", with: @atendimento.funcionario_id
    fill_in "Status agendamento", with: @atendimento.status_agendamento_id
    click_on "Create Atendimento"

    assert_text "Atendimento was successfully created"
    click_on "Back"
  end

  test "should update Atendimento" do
    visit atendimento_url(@atendimento)
    click_on "Edit this atendimento", match: :first

    fill_in "Cliente", with: @atendimento.cliente_id
    fill_in "Data fim", with: @atendimento.data_fim.to_s
    fill_in "Data inicio", with: @atendimento.data_inicio.to_s
    fill_in "Endereco", with: @atendimento.endereco_id
    fill_in "Funcionario", with: @atendimento.funcionario_id
    fill_in "Status agendamento", with: @atendimento.status_agendamento_id
    click_on "Update Atendimento"

    assert_text "Atendimento was successfully updated"
    click_on "Back"
  end

  test "should destroy Atendimento" do
    visit atendimento_url(@atendimento)
    click_on "Destroy this atendimento", match: :first

    assert_text "Atendimento was successfully destroyed"
  end
end
