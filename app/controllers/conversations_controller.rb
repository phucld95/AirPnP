class ConversationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @conversations = Conversation.involving current_user
  end

  def create
    if Conversation.between(params[:sender_id], params[:recipient_id]).present?
      logger.info "dmmmm"
      @conversation = Conversation.between(params[:sender_id], params[:recipient_id]).first
    else
      logger.info "#{}"
      @conversation = Conversation.create(conversation_params)
    end
    logger.info "dmmmmmmmmmmmmmmm  #{@conversation.id}"
    redirect_to conversation_messages_path(@conversation)
  end

  private
  def conversation_params
    params.permit(:sender_id, :recipient_id)
  end
end
