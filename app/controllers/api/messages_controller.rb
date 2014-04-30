class Api::MessagesController < ApplicationController

before_filter :require_signed_in!

  def index
    @sent_messages = current_user.sent_messages.includes(:receiver)
    @received_messages = current_user.received_messages.includes(:sender)

    render :json => @received_messages
  end

  def new
    @message = current_user.sent_messages.new
    @friends = current_user.followers + current_user.leaders
    @friends.uniq!

    render :new
  end

  def create
    @message = current_user.sent_messages.new(message_params)

    if @message.save
      redirect_to message_url(@message)
    else
      flash.now[:errors] = @message.errors.full_messages
      render :new
    end
  end

  def show
    @message = Message.find(params[:id])
    @message.is_seen = true
    @message.save
    render :show
  end

  def destroy
    @message = Message.find(params[:id])

    if @message.sender_delete  && ( @message.sender_delete == @message.receiver_delete )
      @message.destroy
    elsif @message.sender_id == current_user.id
      @message.update(sender_delete: true)
      @m
    elsif @message.receiver_id == current_user.id
      @message.update(receiver_delete: true)
    end

    redirect_to messages_url
  end

  def thread
    @message = Message.find(params[:id])
    @sender = @message.sender
    sender_id = @message.sender_id
    receiver_id = @message.receiver_id
    where_string= "(sender_id = :sender_id AND receiver_id = :receiver_id) OR (sender_id = :receiver_id AND receiver_id = :sender_id)"
    @messages = Message.all
                       .where(where_string, {sender_id: sender_id, receiver_id: receiver_id})
                       .order(:created_at)

    render :thread
  end

  private

  def message_params
    params.require(:message).permit(:body, :receiver_id)
  end

end