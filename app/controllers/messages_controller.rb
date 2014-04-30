class MessagesController < ApplicationController
  
  def index
    @sent_messages = current_user.sent_messages.includes(:receiver)
    @received_messages = current_user.received_messages.includes(:sender)
    
    render :index
  end
  
  def new
    @message = current_user.sent_messages.new
    @friends = current_user.followers + current_user.leaders
    
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
    render :show
  end
  
  private
  
  def message_params
    params.require(:message).permit(:body, :receiver_id)
  end
  
end