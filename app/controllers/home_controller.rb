class HomeController < ApplicationController
  def index
    @avaliacao = Avaliacao.new
      @images = ['image1.jpeg', 'image2.jpeg', 'image3.jpeg', 'image4.jpeg', 'image5.jpeg', 'image6.jpeg'] # Substitua pelos nomes das suas imagens
    # Ordena por data de criação, assumindo que a coluna 'created_at' seja usada para ordenar pela mais recente
    @avaliacoes = Avaliacao.includes(:cliente).where('nota >= ?', 3).order(created_at: :desc).limit(4)
  end

  def create_avaliacao
    cliente = current_user.cliente

    if cliente.present?
      avaliacao = cliente.avaliacaos.build(avaliacao_params)
      avaliacao.data = Date.today
      if avaliacao.save
        redirect_to root_path, notice: 'Avaliação criada com sucesso.'
      else
        # Recarregar as avaliações no caso de erro na criação
        @avaliacoes = Avaliacao.includes(:cliente).where('nota >= ?', 3).order(created_at: :desc).limit(4)
        render :index, alert: 'Erro ao criar avaliação.'
      end
    else
      @avaliacoes = Avaliacao.includes(:cliente).where('nota >= ?', 3).order(created_at: :desc).limit(4)
      render :index, alert: 'Cliente não encontrado.'
    end
  end
  
  private

  def avaliacao_params
    params.require(:avaliacao).permit(:nota, :data, :comentario)
  end
end
