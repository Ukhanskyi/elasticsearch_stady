# frozen_string_literal: true

# class for user controller
class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]

  def index
    search
    # @users = User.all
  end

  def show; end

  def new
    @user = User.new
  end

  def edit; end

  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def search
    @search_users = collection
  end

  private

  def search_params
    params.permit(:query)
  end

  def collection
    if search_params[:query].blank?
      UsersIndex.limit(1000).filter { match_all }
    else
      UsersIndex.limit(1000).query(query_string: { fields: %i[first_name last_name email],
                                                   query: search_params[:query] })
    end
  end

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :phone, :email)
  end
end
