class SessionsController < ApplicationController
    def create
      auth = request.env['omniauth.auth']
        user = User.find_or_create_from_auth(request.env['omniauth.auth'])
        session[:user_id] = user.id
        session[:oauth_token] = auth['credentials']['token']
        session[:oauth_token_secret] = auth['credentials']['secret']
        flash[:notice] = "ユーザ認証が完了しました。"
        redirect_to root_path
    end

    def destroy
        reset_session
        flash[:notice] = "ログアウトしました。"
        redirect_to root_path
    end
end
