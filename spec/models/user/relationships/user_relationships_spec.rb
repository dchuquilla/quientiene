require_relative '../../../rails_helper'

RSpec.describe User, type: :model do
  describe 'Relationships' do
    let(:user) { create(:user) }

    it 'should associate to vehicles' do
      10.times.each { |_t| create(:vehicle, user: user) }
      expect(user.vehicles.count).to eq(10)
    end
    it 'should associate to shops' do
      10.times.each { |_t| create(:shop, user: user) }
      expect(user.shops.count).to eq(10)
    end
  end
end
