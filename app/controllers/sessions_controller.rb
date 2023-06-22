class SessionsController < ApplicationController

  def create
    user = User.find_by(email: params[:email]) # メールアドレスからユーザーを取得するなど、認証情報を検証する処理を追加する必要があります
  
    if user && user.authenticate(params[:password]) # ユーザーが存在し、パスワードが正しい場合
      session[:nickname] = nickname # セッションにユーザーIDを保存してログイン状態を表現します
      redirect_to root_path, notice: "ログインしました" # ログイン後のリダイレクト先やフラッシュメッセージを適宜変更してください
    else
      flash.now[:alert] = "メールアドレスまたはパスワードが正しくありません" # 認証失敗時のエラーメッセージを適宜変更してください
      render :new # ログインページを再表示します
    end
  end

  def destroy
    session[:nickname] = nil # セッションからユーザーIDを削除してログアウト状態を表現します
    redirect_to root_path, notice: "ログアウトしました" # ログアウト後のリダイレクト先やフラッシュメッセージを適宜変更してください
  end  

end