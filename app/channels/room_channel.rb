class RoomChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'room_channel'
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    @msg = Message.create(content: data['message'], user_id: data['user'], conversation_id: data['conversation'])
    ActionCable.server.broadcast 'room_channel', message: @msg.content, user: @msg.user.name, time: @msg.created_at.to_s(:short), identity: data['conversation'] 
  end
end
