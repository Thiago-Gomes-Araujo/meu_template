class ClientesController < ApplicationController
  before_action :set_cliente, only: [:edit, :update]

  def edit
  end

  def update
    if @cliente.update(cliente_params) && update_user_password
      redirect_to servicos_path, notice: "Cliente e usuário atualizados com sucesso."
    else
      # Exibe erros do cliente, incluindo endereços
      Rails.logger.error "Erros no cliente: #{@cliente.errors.full_messages.join(", ")}"
      @cliente.enderecos.each do |endereco|
        Rails.logger.error "Erros no endereço: #{endereco.errors.full_messages.join(", ")}" if endereco.errors.any?
      end
      render :edit
    end
  end

  private

  # Obtém o cliente associado ao usuário
  def set_cliente
    @cliente = current_user.cliente 
    @endereco_principal = @cliente.enderecos.find_by(endereco_principal: true) if @cliente.present?
  end

  # Permite que os atributos do cliente e os atributos aninhados dos endereços sejam atualizados
  def cliente_params
    params.require(:cliente).permit(:nome, :telefone,
      enderecos_attributes: [:id, :descricao, :rua, :cidade, :estado, :cep, :endereco_principal])
  end

  # Atualiza a senha do usuário, se fornecida
  def update_user_password
    if params[:cliente][:password].present? || params[:cliente][:password_confirmation].present?
      # Verifica se a senha atual está correta antes de permitir a atualização
      if @cliente.user.valid_password?(params[:cliente][:current_password])
        # Atualiza o usuário (senha e confirmação de senha)
        if @cliente.user.update(user_params)
          return true
        else
          # Mostra os erros de validação do usuário
          flash.now[:error] = @cliente.user.errors.full_messages.to_sentence
          return false
        end
      else
        flash.now[:error] = 'Senha atual está incorreta.'
        return false
      end
    else
      true # Caso a senha não esteja sendo atualizada, retorna true
    end
  end

  # Permite que o usuário atualize o email e a senha
  def user_params
    params.require(:cliente).permit(:email, :password, :password_confirmation, :current_password)
  end
end
