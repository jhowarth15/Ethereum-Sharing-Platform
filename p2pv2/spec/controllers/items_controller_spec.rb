require 'rails_helper'

describe ItemsController do

  it 'should get items page' do
    get :index
    expect(response.status).to eq(200)
  end

  it 'should get new' do
    user = FactoryGirl.create(:user)
    @request.env['devise.mapping'] = Devise.mappings[:user]
    user.confirm
    sign_in :user, user
    get :new
    expect(response.status).to eq(200)
  end

  it 'should not get new' do
    get :new
    expect(response.status).to redirect_to("/login")
  end

  it 'should create an item' do
    user = FactoryGirl.create(:user)
    @request.env['devise.mapping'] = Devise.mappings[:user]
    user.confirm
    sign_in :user, user
    expect{
      post :create, item: FactoryGirl.attributes_for(:item)
    }.to change(Item, :count).by(1)
    expect(response).to redirect_to("/items/#{assigns(:item).id}")
  end

  it 'should not create an item' do
    user = FactoryGirl.create(:user)
    @request.env['devise.mapping'] = Devise.mappings[:user]
    user.confirm
    sign_in :user, user
    expect{
      post :create, item: FactoryGirl.attributes_for(:item, :location => "  ")
    }.to change(Item, :count).by(0)
    expect(response.status).to eq(200)
    # expect(response).to redirect_to("/items/new")
  end

  it 'should update item' do
    user = FactoryGirl.create(:user)
    @request.env['devise.mapping'] = Devise.mappings[:user]
    user.confirm
    sign_in :user, user
    item = Item.create(name: "New", location: "London", user: user)
    patch :update, id: item.id, item: FactoryGirl.attributes_for(:item)
    expect(response).to redirect_to("/items/#{assigns(:item).id}")
  end

  it 'should not update item' do
    user = FactoryGirl.create(:user)
    @request.env['devise.mapping'] = Devise.mappings[:user]
    user.confirm
    sign_in :user, user
    item = Item.create(name: "New", location: "London", user: user)
    patch :update, id: item.id, item: FactoryGirl.attributes_for(:item, :name => "   ")
    expect(response.status).to eq(200)
    # expect(response).to redirect_to("/items/#{assigns(:item).id}")
  end

  it 'should destroy item' do
    user = FactoryGirl.create(:user)
    @request.env['devise.mapping'] = Devise.mappings[:user]
    user.confirm
    sign_in :user, user
    item = Item.create(name: "New", location: "London", user: user)
    expect{
      delete :destroy, id: item.id
    }.to change(Item, :count).by(-1)
    expect(response).to redirect_to("/items")
  end

  it 'should get address' do
    user = FactoryGirl.create(:user)
    @request.env['devise.mapping'] = Devise.mappings[:user]
    user.confirm
    sign_in :user, user
    item = Item.create(name: "New", location: "London, UK", user: user)
    expect(item.address).to eq("London, UK")
  end

  it 'should search correctly' do
    user = FactoryGirl.create(:user)
    @request.env['devise.mapping'] = Devise.mappings[:user]
    user.confirm
    sign_in :user, user
    item = Item.create(name: "Stuffed Giraffe", location: "London, UK", user: user)
    expect(Item.search("elephant")[0]).to eq(nil)
  end

  it 'should get individual item page' do
    user = FactoryGirl.create(:user)
    @request.env['devise.mapping'] = Devise.mappings[:user]
    user.confirm
    sign_in :user, user
    item = FactoryGirl.create(:item, user: user)
    get :index
    expect(response).to redirect_to("/items/#{assigns(:item).id}")
  end

end