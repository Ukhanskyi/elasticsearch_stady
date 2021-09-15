# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CitiesController, type: :controller do
  render_views

  let!(:city) { FactoryBot.create(:city) }

  describe 'GET #index' do
    it 'renders the :index view' do
      get :index

      expect(response).to have_http_status(200)
      expect(response).to render_template(:index)
    end
  end

  describe 'GET #new' do
    it 'renders the :new view' do
      get :new

      expect(response).to have_http_status(200)
      expect(response).to render_template(:new)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      let!(:params) { FactoryBot.attributes_for(:city) }

      it 'creates new city' do
        expect { post :create, params: { city: params } }.to change(City, :count).by(1)
      end
    end

    context 'with invalid params' do
      let!(:invalid_params) { FactoryBot.attributes_for(:city, name: nil) }

      it 'does not create new city' do
        expect { post :create, params: { city: invalid_params } }.not_to change(City, :count)
      end
    end
  end

  describe 'PUT #update' do
    context 'valid attributes' do
      it 'changes cities attributes' do
        put :update, params: { id: city.id, city: { name: 'Edited' } }
        city.reload

        expect(city.name).to eq('Edited')
        expect(response).to have_http_status(302)
        expect(response).to redirect_to(city_path)
      end
    end

    context 'invalid attributes' do
      it 'does not change cities attributes' do
        put :update, params: { id: city.id, city: { name: nil } }
        city.reload

        expect(city.name).not_to eq(nil)
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes the city' do
      expect { delete :destroy, params: { id: city.id } }.to change(City, :count).by(-1)
    end

    it 'redirects to cities#index' do
      delete :destroy, params: { id: city.id }
      expect(response).to have_http_status(302)
      expect(response).to redirect_to(cities_path)
    end
  end
end
