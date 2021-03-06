class TweetsController < ApplicationController
  before_action :set_tweet, only: [:edit, :show]    #同じコードはまとめられる
  bbefore_action :move_to_index, except: [:index, :show, :search]

  def index
    @tweets = Tweet.includes(:user).order("created_at DESC")
  end

  def new #データの投稿画面の表示
    @tweet = Tweet.new #new.htmlで使う為にインスタンス変数を定義
  end

  def create #データの保存(テーブルに追加)
    binding.pry
    Tweet.create(tweet_params) #ストロングパラメーター(指定したキーを持つパラメーターのみを受け取るように制限するもの)で定義
   #意図しないデータの更新(他人のログインパスワードを変更するパラメーターを追加で送信して、勝手にパスワードを変更等)
  end

  def destroy
    tweet = Tweet.find(params[:id]) #index.htmlの削除ボタンで指定したtweet_idを意味
    tweet.destroy
  end

  def edit
    @tweet = Tweet.find(params[:id]) #index.htmlの編集ボタンで指定したtweet_idを意味
    #edit.htmlで使う為にインスタンス変数を定義
  end

  def update
    tweet = Tweet.find(params[:id]) #edit.htmlの送信ボタンで指定したtweet_idを意味
    tweet.update(tweet_params)
  end

  def show
    @comment = Comment.new
    @comments = @tweet.comments.includes(:user)
  end

  def search
    @tweets = Tweet.search(params[:keyword])
  end

  private #クラス外から呼び出すことのできないメソッド
  def tweet_params
    params.require(:tweet).permit(:image, :text).merge(user_id: current_user.id)
    #params.require(:モデル名).permit(:キー名, :キー名)取得したいキーを指定する
  end

  def set_tweet                   #同じコードはまとめられる
    @tweet = Tweet.find(params[:id])
  end

  def move_to_index
    unless user_signed_in?
      redirect_to action: :index
    end
  end
end