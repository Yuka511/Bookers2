class ApplicationController < ActionController::Base
  before_action :authenticate_user!, except: [:top, :about] # top,aboutの2つのアクションのみ、ログインなしでもアクセスを可能にする
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  def after_sign_in_path_for(resource)
    user_path(current_user) # ログイン直後は、ユーザーの詳細ページへ遷移
  end
  
  def after_sign_out_path_for(resource)
    root_path
  end
  
  protected
  
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email])
  end
end
