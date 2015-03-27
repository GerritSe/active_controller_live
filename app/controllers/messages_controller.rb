class MessagesController < ApplicationController
  include ActionController::Live

  def create
    @message = Message.create!(message_params) rescue nil
    $redis.publish('messages.create', @message.to_json) unless @message.nil?

    respond_to do |format|
      format.json {render json: {status: !@message.nil?}}
    end
  end

  def events
    response.headers['Content-Type'] = 'text/event-stream'
    redis = Redis.new
    redis.subscribe('messages.create') do |on|
      on.message do |event, data|
        response.stream.write "data: #{data}\n\n"
      end
    end
  rescue IOError
    logger.info 'Stream closed'
  ensure
    redis.quit
    response.stream.close
  end

  private

  def message_params
    params.permit(:chatroom_id, :user, :message)
  end
end
