# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  render_views

  let!(:user) { FactoryBot.create(:user) }

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
      let!(:params) { FactoryBot.attributes_for(:user) }

      it 'creates new kid' do
        expect { post :create, params: { user: params } }.to change(User, :count).by(1)
      end
    end

    context 'with invalid params' do
      let!(:invalid_params) { FactoryBot.attributes_for(:user, email: nil) }

      it 'does not create new user' do
        expect { post :create, params: { user: invalid_params } }.not_to change(User, :count)
      end
      it 'renders form' do
        post :create, params: { user: invalid_params }
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'PUT #update' do
    context 'valid attributes' do
      it 'changes users attributes' do
        put :update, params: { id: user.id, user: { first_name: 'Edited' } }
        user.reload

        expect(user.first_name).to eq('Edited')
        expect(response).to have_http_status(302)
        expect(response).to redirect_to(user_path)
      end
    end

    context 'invalid attributes' do
      it 'does not change users attributes' do
        put :update, params: { id: user.id, user: { email: nil } }
        user.reload

        expect(user.email).not_to eq(nil)
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes the user' do
      expect { delete :destroy, params: { id: user.id } }.to change(User, :count).by(-1)
    end

    it 'redirects to consultation#index' do
      delete :destroy, params: { id: user.id }
      expect(response).to have_http_status(302)
      expect(response).to redirect_to(users_path)
    end
  end

  describe 'POST #search' do
    let!(:user) { FactoryBot.create(:user, first_name: 'Test_first_name', last_name: 'Test_last_name') }

    it 'returns true' do
      post :search, params: { query: 'Test_first_name' }, format: :turbo_stream

      expect(response).to render_template(partial: 'users/_search_results')
    end
  end
end
