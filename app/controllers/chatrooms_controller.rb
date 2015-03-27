class ChatroomsController < ApplicationController
  before_action :set_chatroom

  def index
    @chatroom_list = Chatroom.all
  end

  def show
  end

  private

  def set_chatroom
    @chatroom = Chatroom.find(chatroom_params[:id]) unless chatroom_params[:id].nil?
  end

  def chatroom_params
    params.permit(:id)
  end
end
