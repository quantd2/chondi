class ContactsController < ApplicationController
  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(params[:contact])
    @contact.request = request
    if @contact.deliver
      flash[:notice] = 'Cám ơn tin nhắn của bạn, chúng tôi sẽ liên lạc với bạn nhanh nhất có thể.'
      # ContactMailer.contact_me(@contact).deliver
      redirect_to root_path
    else
      flash[:error] = 'Không thể gửi tin nhắn, vui lòng thử lại sau.'
      render :new
    end
  end
end
