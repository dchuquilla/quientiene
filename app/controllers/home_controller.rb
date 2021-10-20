# frozen_string_literal: true

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
    @title = 'Contáctenos, chat en línea'
  end

end
