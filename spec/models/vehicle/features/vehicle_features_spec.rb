# frozen_string_literal: true

require_relative '../../../rails_helper'

RSpec.describe Vehicle, type: :model do
  context 'Features' do
    let(:user) { create(:user) }

    describe 'scopes' do
      before(:each) do
        create_list(:vehicle, 10, user: user)
      end

      it 'should show las 10 ordered from recent' do
        recents = Vehicle.recent(10)
        aggregate_failures do
          expect(recents.count).to eq(10)
          expect(recents.first.id).to be > recents.last.id
        end
      end

      it 'should show all brands' do
        brands = Vehicle.all_brands
        expect(brands.first).to eq('Ford')
      end

      it 'should show all years' do
        years = Vehicle.all_years
        expect(years.first).to eq(2023)
      end
    end
  end
end
