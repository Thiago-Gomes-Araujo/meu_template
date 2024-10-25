Rails.application.routes.draw do
  resources :clientes, only: [:edit, :update]
  # resources :atendimentos
  resources :itinerarios
  resources :servicos
  resources :enderecos
  resources :funcionarios
  devise_for :users
  root "home#index"
  post 'create_avaliacao', to: 'home#create_avaliacao'

 # config/routes.rb
 resources :atendimentos do
  post :set_data_inicio, on: :member
  post :set_data_fim, on: :member
  patch :atualizar_funcionario, on: :member
end

end
