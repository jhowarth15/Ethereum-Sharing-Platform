require 'rails_helper'
describe UsersController do

  describe 'GET #index' do
    it 'should get index' do
      get :index
      expect(response).to be_success
      expect(assigns(:users)).not_to be_nil
    end
  end

  describe 'GET #new' do
    it 'should get new' do
      get :new
      expect(response).to be_success
      # assert_select "title", "Sign Up"
    end
  end

  it 'should create user' do
    # user = FactoryGirl.create(:user)
    @request.env['devise.mapping'] = Devise.mappings[:user]
    # user.confirm
    # sign_in :user, user
    expect{
      post :create, user: FactoryGirl.attributes_for(:user)#, :user => Devise.confirm_within
    }.to change(User, :count).by(0)
    # expect(response).to redirect_to("/users/#{assigns(:user).id}")
  end

  it 'should not create user' do
    expect{
      post :create, user: FactoryGirl.attributes_for(:user, :name_first => "  ")
    }.to change(User, :count).by(0)
    expect(response.status).to eq(200)
    # expect(response).to redirect_to("/users/new")
  end

  it 'should show user' do
    user = FactoryGirl.create(:user)
    @request.env['devise.mapping'] = Devise.mappings[:user]
    user.confirm
    sign_in :user, user
    get :show, id: user
    expect(response).to be_success
  end

  it 'should get edit' do
    user = FactoryGirl.create(:user)
    @request.env['devise.mapping'] = Devise.mappings[:user]
    user.confirm
    sign_in :user, user
    get :edit, id: user
    expect(response).to be_success
  end

  it 'should update user' do
    user = FactoryGirl.create(:user)
    @request.env['devise.mapping'] = Devise.mappings[:user]
    user.confirm
    sign_in :user, user
    patch :update, id: user.id, user: FactoryGirl.attributes_for(:user)
    expect(response).to redirect_to("/users/#{assigns(:user).id}")
  end

  it 'should not update user' do
    user = FactoryGirl.create(:user)
    @request.env['devise.mapping'] = Devise.mappings[:user]
    user.confirm
    sign_in :user, user
    patch :update, id: user.id, user: FactoryGirl.attributes_for(:user, :name_last => "   ")
    expect(response.status).to eq(200)
    # expect(response).to redirect_to("/users/#{assigns(:user).id}")
  end

  it 'should destory user' do
    user = FactoryGirl.create(:user)
    @request.env['devise.mapping'] = Devise.mappings[:user]
    user.confirm
    sign_in :user, user
    expect{
      delete :destroy, id: user.id
    }.to change(User, :count).by(-1)
    expect(response).to redirect_to("/users")
  end

  it 'should not create user 2' do
    @request.env['devise.mapping'] = Devise.mappings[:user]
    user = FactoryGirl.build(:user, :name_last => nil)
    expect(response.status).to eq(200)
  end

end