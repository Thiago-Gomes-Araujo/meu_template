class EnderecosController < ApplicationController
  before_action :authenticate_user!  # Garantir que o usuário está logado antes de qualquer ação
  before_action :set_endereco, only: [:show, :edit, :update, :destroy]  # Usar callback para encontrar endereço

  def index
    if current_user.admin?
      # Se o usuário for admin, busca todos os endereços
      @enderecos = Endereco.ransack(params[:q]) # Supondo que Endereco é o nome do modelo
    else
      # Se não, busca apenas os endereços do cliente do usuário atual
      @enderecos = current_user.cliente.enderecos.ransack(params[:q])
    end

    @pagy, @endereco = pagy(@enderecos.result)
  end
  
  def show
    # @endereco já definido pelo before_action
  end

  def new
    @endereco = Endereco.new
  end

  def create
    @endereco = current_user.cliente.enderecos.build(endereco_params) # Associar o endereço ao cliente do usuário logado
    if @endereco.save
      redirect_to enderecos_path, notice: 'Endereço criado com sucesso!'
    else
      render :new
    end
  end

  def edit
    # @endereco já definido pelo before_action
  end
  
  def update
    if @endereco.update(endereco_params)
      redirect_to enderecos_path, notice: 'Endereço atualizado com sucesso!'
    else
      render :edit
    end
  end

  def destroy
    @endereco.destroy
    redirect_to enderecos_path, notice: 'Endereço excluído com sucesso!'
  end

  private

  def set_endereco
    @endereco = Endereco.find(params[:id])
    # Verifica se o usuário é administrador ou se o endereço pertence ao cliente do usuário logado
    unless current_user.admin? || @endereco.cliente == current_user.cliente
      redirect_to enderecos_path, alert: 'Você não tem permissão para acessar este endereço.'
    end
  end


  private

  def endereco_params
    params.require(:endereco).permit(:descricao, :rua, :cidade, :estado, :cep, :endereco_principal)
  end
end
