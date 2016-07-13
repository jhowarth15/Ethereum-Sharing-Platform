require 'rails_helper'

describe Users::RegistrationsController do

  it 'should create user' do
    # user = FactoryGirl.build(:user)
    @request.env['devise.mapping'] = Devise.mappings[:user]
    # user.confirm
    # sign_in :user, user
    expect{
      post :create, user: FactoryGirl.attributes_for(:user)
    }.to change(User, :count).by(1)
    expect(response).to redirect_to("/users/#{assigns(:user).id}")
  end

  it 'should not create user' do
    @request.env['devise.mapping'] = Devise.mappings[:user]
    expect{
      post :create, user: FactoryGirl.attributes_for(:user, :name_first => "  ")
    }.to change(User, :count).by(0)
    expect(response.status).to eq(200)
  end

  it 'should not update user' do
    @request.env['devise.mapping'] = Devise.mappings[:user]
    user = FactoryGirl.build(:user, :name_first => nil)
    expect(response.status).to eq(200)
  end
end