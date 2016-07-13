require 'rails_helper'

describe ContractsController do

  let(:contract) { create :contract }

  it 'should get contract page' do
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

  it 'should create an contract' do
    user = FactoryGirl.create(:user)
    @request.env['devise.mapping'] = Devise.mappings[:user]
    user.confirm
    sign_in :user, user
    expect{
      post :create, contract: FactoryGirl.attributes_for(:contract)
    }.to change(Contract, :count).by(1)
    expect(response).to redirect_to("/contracts/#{assigns(:contract).id}")
  end

  it 'should not create an contract' do
    expect{
      post :create, contract: FactoryGirl.attributes_for(:contract, :lender_id => nil)
    }.to change(Contract, :count).by(0)
    expect(response.status).to eq(200)
    # expect(response).to redirect_to("/contracts/new")
  end

  it 'should not create an contract' do
    expect{
      post :create, contract: FactoryGirl.attributes_for(:contract, :inquirer_id => nil)
    }.to change(Contract, :count).by(0)
    expect(response.status).to eq(200)
  end

  it 'should update contract' do
    patch :update, id: contract.id, contract: FactoryGirl.attributes_for(:contract)
    expect(response).to redirect_to("/contracts/#{assigns(:contract).id}")
  end

  it 'should not update contract' do
    patch :update, id: contract.id, contract: FactoryGirl.attributes_for(:contract, :lender_id => nil)
    expect(response.status).to eq(200)
  end

  it 'should destory contract' do
    expect{
      delete :destroy, id: contract.id
    }.to change(Contract, :count).by(0)
    expect(response).to redirect_to("/contracts")
  end

  it 'should initiate contract' do
    user = FactoryGirl.create(:user)
    @request.env['devise.mapping'] = Devise.mappings[:user]
    user.confirm
    sign_in :user, user
    expect{
      put :initiate, contract: FactoryGirl.attributes_for(:contract)
    }.to change(Contract, :count).by(1)
    expect(response).to redirect_to("/contracts/#{assigns(:contract).id}")
  end

  it 'should initiate a contract 2' do
    post :initiate, id: contract.id, contract: FactoryGirl.attributes_for(:contract)
    expect(response).to redirect_to("/contracts/#{assigns(:contract).id}")
  end

end