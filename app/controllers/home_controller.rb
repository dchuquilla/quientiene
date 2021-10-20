class HomeController < ApplicationController
  def index
    redirect_to dashboard_path if current_user.present?
    @current_brands = Vehicle.select(:brand).distinct.map { |v| v.brand.strip }.uniq
  end

  def signup; end

  def privacy_policy
    @title = 'Política de privacidad'
  end

  def business
    @title = 'Empresas, venta de repuestos atuomotrices, quiero registrar mi empresa'
  end

  def contact_us
    @contact = Home.new(params[:home])
    @title = 'Contáctenos, chat en línea'
  end

  def create
    @contact = Home.new(params[:home])
    @contact.request = request
    respond_to do |format|
      if @contact.deliver
        # re-initialize Home object for cleared form
        @contact = Home.new
        format.html { render 'index' }
        format.js   { flash.now[:success] = @message = "Thank you for your message. I'll get back to you soon!" }
      else
        format.html { render 'index' }
        format.js   { flash.now[:error] = @message = 'Message did not send.' }
      end
    end
  end
end
