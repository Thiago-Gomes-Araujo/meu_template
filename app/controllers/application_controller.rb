class ApplicationController < ActionController::Base
  
  include Pagy::Backend
  layout :set_layout

  def set_layout
    if devise_controller?
      "devise"
    else
      "application"
    end
  end
  # Captura a exceção AccessDenied do CanCanCan
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, alert: exception.message
  end
  
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nome, :telefone])
  end
end
