class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_conversation

  def index
    if current_user == @conversation.sender || current_user == @conversation.recipient
      @other = current_user == @conversation.sender ? @conversation.recipient : @conversation.sender
      @messages = @conversation.messages.order(created_at: :desc)
    else
      redirect_to conversations_path, alert: t(".you_dont_have_permission_to_view_this")
    end
  end

  def create
    @message = @conversation.messages.new message_params
    @messages = @conversation.messages.order(create_at: :desc)

    if @message.save
      ActionCable.server.broadcast "conversation_#{@conversation.id}", message: render_message(@message)
    end
  end

  private

  def render_message message
    self.render(partial: "messages/message", locals: {message: message})
  end

  def set_conversation
    @conversation = Conversation.find_by id: params[:conversation_id]
  end

  def message_params
    params.require(:message).permit(:content, :user_id)
  end
end
