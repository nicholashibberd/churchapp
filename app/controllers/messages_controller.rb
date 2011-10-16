class MessagesController < ApplicationController
  skip_before_filter :login_required, :only => :create
  layout 'admin'
  
  def index
    @messages = @church.messages
  end

  def show
    @message = Message.find(params[:id])
  end

  def create
    @message = Message.new(params[:message])
    church = @message.church
    page = Page.find(params[:page_id])
    if @message.save
      notice = 'Thank you for your message!'
    else
      notice = 'There was an error sending this message'
    end
    redirect_to church_page_path(church, page), :notice => notice
  end

  def destroy
    @message = Message.find(params[:id])
    church = @message.church
    @message.destroy
    redirect_to messages_path(church)
  end
end
