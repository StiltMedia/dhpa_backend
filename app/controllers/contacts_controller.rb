class ContactsController < ApplicationController
  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(params[:contact])
    @contact.request = request
    begin
      if @contact.deliver
        flash[:success] = 'Thank you for your message. We will contact you soon!'
        redirect_to :back
      else
        flash[:error] = "Cannot send message: #{@contact.errors.full_messages.join('; ')}"
        render :new
      end
    rescue Exception => e
      flash[:error] = "Error sending message: #{e.message}"
      render :new
    end
  end
end