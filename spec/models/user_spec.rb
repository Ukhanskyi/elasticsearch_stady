# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'factories' do
    it 'has valid factory' do
      expect(FactoryBot.create(:user)).to be_valid
    end
  end
end
