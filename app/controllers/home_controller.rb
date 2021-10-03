class HomeController < ApplicationController
  def index
    if current_user.id.present?
      redirect_to dashboard_path
    end
  end

  def signup
  end

  def privacy_policy
    @title = "QuienTiene :: Política de privacidad"
  end

  def business
    @title = "QuienTiene :: Empresas"
  end

  def contact_us
    @contact = Home.new(params[:home])
    @title = "QuienTiene :: Contáctenos"
  end

  def create
    @contact = Home.new(params[:home])
    @contact.request = request
    respond_to do |format|
      if @contact.deliver
        # re-initialize Home object for cleared form
        @contact = Home.new
        format.html { render 'index'}
        format.js   { flash.now[:success] = @message = "Thank you for your message. I'll get back to you soon!" }
      else
        format.html { render 'index' }
        format.js   { flash.now[:error] = @message = "Message did not send." }
      end
    end
  end
  
end
