# frozen_string_literal: true

require_relative '../../../rails_helper'

RSpec.describe Vehicle, type: :model do
  context 'DB constraints' do
    describe 'presence true' do
      it 'should validate presence of :user, :brand, :model, :year' do
        vehicle = Vehicle.new
        expect(vehicle.valid?).not_to be_truthy
        expect(vehicle.errors.full_messages).to eq(['Usuario debe existir',
                                                    'Marca no puede estar en blanco',
                                                    'Modelo no puede estar en blanco',
                                                    'año no puede estar en blanco',
                                                    'año no es un número'])
      end
      it 'should validate year format' do
        user = create(:user)
        vehicle = build(:vehicle, user: user, year: 'YYYY')
        expect(vehicle.valid?).not_to be_truthy
        expect(vehicle.errors.full_messages).to eq(['año no es un número'])
      end
    end
  end
end
