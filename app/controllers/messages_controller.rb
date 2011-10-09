class MessagesController < ApplicationController
  layout 'admin'
  
  def index
    @messages = @church.messages
  end

  def show
    @message = Message.find(params[:id])
  end

  def new
    @message = @church.messages.new
  end

  def edit
    @message = Message.find(params[:id])
  end

  def create
    @message = Message.new(params[:message])
    page = Page.find(params[:page_id])
    if @message.save
      notice = 'Thank you for your message!'
    else
      notice = 'There was an error sending this message'
    end
    redirect_to church_page_path(@church, page), :notice => notice
  end

  def update
    @message = Message.find(params[:id])

    if @message.update_attributes(params[:message])
      redirect_to(messages_path(@church), :notice => 'Message was successfully updated.')
    else
      render :action => "edit"
    end
  end

  def destroy
    @message = Message.find(params[:id])
    @message.destroy

    respond_to do |format|
      format.html { redirect_to(messages_url) }
      format.xml  { head :ok }
    end
  end
end
