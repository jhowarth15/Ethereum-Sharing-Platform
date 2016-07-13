require 'rails_helper'

describe StaticPagesController do

  let(:user) { create :user }

  it 'displays home page' do
    visit root_path
    expect(page).to have_content 'Our Amazing Team'
    expect(page.status_code).to eq 200
  end

  it 'displays new_user_session correctly' do
    visit new_user_session_path
    expect(page.status_code).to eq 200
  end

  it 'displays new_user_password correctly' do
    visit new_user_password_path
    expect(page.status_code).to eq 200
  end

  it 'displays edit_user_password correctly' do
    visit edit_user_password_path
    expect(page.status_code).to eq 200
  end

  it 'displays cancel_user_registration correctly' do
    visit cancel_user_registration_path
    expect(page.status_code).to eq 200
  end

  it 'displays new_user_registration correctly' do
    visit new_user_registration_path
    expect(page.status_code).to eq 200
  end

  it 'displays edit_user_registration correctly' do
    visit edit_user_registration_path
    expect(page.status_code).to eq 200
  end

  it 'displays new_user_confirmation correctly' do
    visit new_user_confirmation_path
    expect(page.status_code).to eq 200
  end

  it 'displays new_user_unlock correctly' do
    visit new_user_unlock_path
    expect(page.status_code).to eq 200
  end

  it 'displays root correctly' do
    visit root_path
    expect(page.status_code).to eq 200
  end

  it 'displays howtoborrow correctly' do
    visit howtoborrow_path
    expect(page.status_code).to eq 200
  end

  it 'displays howtolend correctly' do
    visit howtolend_path
    expect(page.status_code).to eq 200
  end

  it 'displays search_items correctly' do
    visit search_items_path
    expect(page.status_code).to eq 200
  end

  it 'displays signup correctly' do
    visit signup_path
    expect(page.status_code).to eq 200
  end

  it 'displays login correctly' do
    visit login_path
    expect(page.status_code).to eq 200
  end

  it 'displays edit_user correctly' do
    visit edit_user_path
    expect(page.status_code).to eq 200
  end

  it 'displays users correctly' do
    visit users_path
    expect(page.status_code).to eq 200
  end

  it 'displays new_user correctly' do
    visit new_user_path
    expect(page.status_code).to eq 200
  end

  # it 'displays user correctly' do
  #   visit user_path
  #   expect(page.status_code).to eq 200
  # end

  it 'displays new_item correctly' do
    visit new_item_path
    expect(page.status_code).to eq 200
  end

  it 'displays items_index correctly' do
    visit items_path
    expect(page.status_code).to eq 200
  end

  it 'displays contracts correctly' do
    visit contracts_path
    expect(page.status_code).to eq 200
  end

end