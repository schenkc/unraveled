class Api::MessagesController < ApplicationController

before_filter :require_signed_in!

  def index
    @sent_messages = current_user.sent_messages.includes(:receiver)
    @received_messages = current_user.received_messages.includes(:sender)

    render :json => @received_messages
  end


  def create
    @message = current_user.sent_messages.new(message_params)

    if @message.save
      render :json => @message
    else
      render :json => @message.errors.full_messages, status: :unprocessable_entity
    end
  end

  def update
    @message = Message.find(params[:id])
    @message.update(message_params)
    render :json => @message
  end

  def show
    @message = Message.find(params[:id])
    render :json => @message
  end

  def destroy
    @message = Message.find(params[:id])

    if @message.sender_delete  && ( @message.sender_delete == @message.receiver_delete )
      @message.destroy
    elsif @message.sender_id == current_user.id
      @message.update(sender_delete: true)
    elsif @message.receiver_id == current_user.id
      @message.update(receiver_delete: true)
    end

    head :ok
  end


  private

  def message_params
    params.require(:message).permit(:body, :receiver_id)
  end

end