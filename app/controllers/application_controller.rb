class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    helper_method :current_user, :logged_in?, :authenticate, :login_required

    def login_required
      return unless session[:user_id]
      @current_user ||= User.find_by(uid: session[:user_id])
      end
    end

    private

    def current_user
      return unless session[:user_id]
      @current_user ||= User.find_by(uid: session[:user_id])
    end

    def logged_in?
      !!session[:user_id]
    end

    def authenticate
      return if logged_in?
      redirect_to root_path, alert: "ログインしてください"
    end
