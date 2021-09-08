# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UsersSearch do
  let!(:user) { FactoryBot.create(:user, first_name: 'Test_first_name', last_name: 'Test_last_name') }
  let!(:user2) { FactoryBot.create(:user, first_name: 'Test2_first_name', last_name: 'Test2_last_name') }

  before do
    UsersIndex.reset!
  end

  context 'when searching by first_name' do
    let(:finded_user) do
      described_class.new(query: 'Test_first_name').search.to_a[0]
    end

    it do
      expect(finded_user.first_name).to eq('Test_first_name')
    end
  end

  context 'when searching by empty field' do
    let(:finded_users) do
      described_class.new(query: '').search.to_a
    end

    it do
      expect(finded_users.length).to eq 2
    end
  end
end
