class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show]
  def index
    @user = User.all
  end

  def show
    @user = User.find(params[:id])
    @currentRoomUser = RoomUser.where(user_id: current_user.id)  #current_userが既にルームに参加しているか判断
    @receiveUser = RoomUser.where(user_id: @user.id)  #他の@userがルームに参加しているか判断
    unless @user.id == current_user.id  #current_userと@userが一致していなければ
      @currentRoomUser.each do |cu|    #current_userが参加していルームを取り出す
        @receiveUser.each do |u|    #@userが参加しているルームを取り出す
          if cu.room_id == u.room_id    #current_userと@userのルームが同じか判断(既にルームが作られているか)
            @haveRoom = true    #falseの時(同じじゃない時)の条件を記述するために変数に代入
            @roomId = cu.room_id   #ルームが共通しているcurrent_userと@userに対して変数を指定
          end
        end
      end
      unless @haveroom    #ルームが同じじゃなければ
        #新しいインスタンスを生成
        @room = Room.new
        @RoomUser = RoomUser.new
        #//新しいインスタンスを生成
      end
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_update_params)
    redirect_to root_path
  end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
    redirect_to root_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :caption, :image)
  end
end
