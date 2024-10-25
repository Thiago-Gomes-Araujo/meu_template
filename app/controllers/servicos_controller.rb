class ServicosController < ApplicationController
  before_action :set_servico, only: [:show, :edit, :update, :destroy] # Alterado para incluir apenas ações necessárias
  before_action :authenticate_user!, except: [:index, :show]

  def index
    if params[:query].present?
      query = params[:query]
      @servicos = Servico.where('titulo ILIKE :query OR descricao ILIKE :query', query: "%#{query}%")
    else
      @servicos = Servico.all
    end
    @pagy, @servicos = pagy(@servicos)
  end


  def show
  end

  def new
    @servico = Servico.new
  end


  def edit
  end

  def create
    @servico = Servico.new(servico_params)

    respond_to do |format|
      if @servico.save
        format.html { redirect_to @servico, notice: "Serviço criado com sucesso." }
        format.json { render :show, status: :created, location: @servico }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @servico.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @servico.update(servico_params)
        format.html { redirect_to @servico, notice: "Serviço atualizado com sucesso." }
        format.json { render :show, status: :ok, location: @servico }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @servico.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    if @servico
      @servico.destroy
      respond_to do |format|
        format.html { redirect_to servicos_path, notice: "Serviço excluído com sucesso." }
        format.json { head :no_content }
      end
    else
      redirect_to servicos_path, alert: "Serviço não encontrado."
    end
  end

  private

  def set_servico
    @servico = Servico.find_by(id: params[:id]) 
    unless @servico
      redirect_to servicos_path, alert: "Serviço não encontrado." 
    end
  end
  def servico_params
    params.require(:servico).permit(:titulo, :descricao, :valor)
  end
end
