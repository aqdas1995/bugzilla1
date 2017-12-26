class ConversationsController < ApplicationController
  before_action :set_conversation, only: %i[fetch_messages fetch_user]

  def show
    @conversations = Conversation.joins(:user_conversations).where(user_conversations: {user_id: current_user.id})
  end

  def fetch_messages
    @messages = []
    @conversation.messages.each do |msg|
      message = { content: msg.content, sender: msg.user.name, time: msg.created_at.to_s(:short) }
      @messages.insert(0, message)
    end
    respond_to do |format|
      format.json do
        render json: @messages.to_json
      end
    end
  end

  def fetch_user
    @_user = User.all
    respond_to do |format|
      format.json do
        render json: @_user.to_json
      end
    end
  end

  def add_to_conversation
    check = UserConversation.find_by(user_id: params[:user_id], conversation_id: params[:conversation_id])
    if check.nil?
      UserConversation.create(add_params)
      flash[:notice] = 'User sucessfully added to the converastion'
    else
      flash[:notice] = 'User already added to the converastion'
    end
  end

  def create
    Conversation.create(name: params[:name]).user_conversations.create(user_id: params[:user_id])
  end

  private

  def set_conversation
    @conversation = Conversation.find(params[:id])
  end

  def add_params
    params.permit(:conversation_id, :user_id)
  end

  def create_params
    parmas.permit(:user_id, :name)
  end
end
