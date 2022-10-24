# frozen_string_literal: true

require_relative '../../../rails_helper'

RSpec.describe Vehicle, type: :model do
  context 'Relationchips' do
    let(:user) { create(:user) }
    let(:vehicle) { create(:vehicle, user: user) }
    describe 'user' do
      it 'should belongs to a user' do
        vehicle_r = build(:vehicle)
        expect(vehicle_r.valid?).not_to be_truthy
        expect(vehicle_r.errors.full_messages).to eq(['Usuario debe existir'])
      end
    end

    describe 'Replacement Requests' do
      it 'should have many replacement_requests' do
        10.times.each { |_t| create(:replacement_request, vehicle: vehicle, user: user) }
        expect(vehicle.replacement_requests.count).to eq(10)
      end
    end
  end
end
