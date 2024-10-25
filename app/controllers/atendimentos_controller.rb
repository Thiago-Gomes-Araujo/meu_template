class AtendimentosController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!
  before_action :set_atendimento, only: [:show, :edit, :update, :destroy, :set_data_inicio, :set_data_fim]

  # GET /atendimentos or /atendimentos.json
  def index
    @q = Atendimento.ransack(params[:q]) 
    
    if current_user&.admin?
      @atendimentos = @q.result.order(created_at: :asc)
    elsif current_user
      @atendimentos = @q.result.where(cliente: current_user.cliente).order(created_at: :asc)
    else
      @atendimentos = Atendimento.none # Se não há usuário logado, não retorna atendimentos
    end
  
    
    @pagy, @atendimentos = pagy(@atendimentos, items: 10)
  end
  

  # GET /atendimentos/1 or /atendimentos/1.json
  def show
    if @atendimento.endereco.nil?
      # Redireciona para a ação de edição do endereço
      redirect_to edit_endereco_path(@atendimento.endereco_id), alert: 'Por favor, atualize o endereço antes de visualizar o atendimento.' and return
    end
  end

  # GET /atendimentos/new
  def new
    @atendimento = Atendimento.new
  end

  # GET /atendimentos/1/edit
  def edit
  end

  # POST /atendimentos
  # POST /atendimentos
  def create
    @atendimento = Atendimento.new(atendimento_params)
    @atendimento.cliente = current_user.cliente
    @atendimento.status_agendamento = StatusAgendamento.find_by(descricao: "Pending")
    
    # Valida o endereço antes de salvar
    endereco = Endereco.find_by(id: params[:atendimento][:endereco_id])
    if endereco.nil? || !endereco.valid?
      # Adiciona erro no atendimento em vez de redirecionar
      @atendimento.errors.add(:endereco_id, "não é válido ou não foi selecionado.")
      respond_to do |format|
        # Exibe o formulário novamente com os erros
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @atendimento.errors, status: :unprocessable_entity }
      end
      return
    end
  
    respond_to do |format|
      if @atendimento.save
        # Se salvo com sucesso, redireciona para o index
        format.html { redirect_to atendimentos_path, notice: 'Atendimento foi criado com sucesso.' }
        format.json { render :show, status: :created, location: @atendimento }
      else
        # Se falhar, exibe o formulário novamente com erros de validação
        Rails.logger.debug("Atendimento Errors: #{@atendimento.errors.full_messages.join(", ")}")
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @atendimento.errors, status: :unprocessable_entity }
      end
    end
  end
  

# PATCH/PUT /atendimentos/1
def update
  respond_to do |format|
    if @atendimento.update(atendimento_params)
      format.html { redirect_to atendimentos_path, notice: 'Atendimento was successfully updated.' }
      format.json { render :show, status: :ok, location: @atendimento }
    else
      Rails.logger.debug("Atendimento Update Errors: #{@atendimento.errors.full_messages.join(", ")}")
      format.html { render :edit, status: :unprocessable_entity }
      format.json { render json: @atendimento.errors, status: :unprocessable_entity }
    end
  end
end


  # DELETE /atendimentos/1
  def destroy
    @atendimento.destroy!
    respond_to do |format|
      format.html { redirect_to atendimentos_path, status: :see_other, notice: "Atendimento was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  # Custom actions for setting data_inicio and data_fim
  def set_data_inicio
    if @atendimento.update(data_inicio: Time.current, status_agendamento_id: 2)
      flash[:notice] = "Data de início definida e status atualizado para In Progress."
      redirect_to atendimentos_path
    else
      flash[:alert] = "Erro ao definir a data de início."
      render :edit
    end
  end

  def set_data_fim
    if @atendimento.update(data_fim: Time.current, status_agendamento_id: 3)
      flash[:notice] = "Data de fim definida e status atualizado para Completed."
      redirect_to atendimentos_path
    else
      flash[:alert] = "Erro ao definir a data de fim."
      render :edit
    end
  end

  def atualizar_funcionario
    @atendimento = Atendimento.find(params[:id])
    if @atendimento.update(atendimento_params)
      respond_to do |format|
        format.js # responderá ao JavaScript com um arquivo .js.erb
      end
    else
      # Aqui você pode lidar com o erro caso a atualização falhe
      respond_to do |format|
        format.js { render 'error' } # ou qualquer ação que você queira
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_atendimento
    @atendimento = Atendimento.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  # Garante que apenas administradores podem enviar o parâmetro :funcionario_id
  def atendimento_params
    if current_user.admin?
      params.require(:atendimento).permit(:data_inicio, :data_fim, :status_agendamento_id, :cliente_id, :endereco_id, :funcionario_id, servico_ids: [])
    else
      params.require(:atendimento).permit(:data_inicio, :data_fim, :status_agendamento_id, :cliente_id, :endereco_id, servico_ids: [])
    end
  end
end
