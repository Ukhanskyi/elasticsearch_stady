# frozen_string_literal: true

require 'rails_helper'

RSpec.describe City, type: :model do
  describe 'factories' do
    it 'has valid factory' do
      expect(FactoryBot.create(:city)).to be_valid
    end
  end
end
