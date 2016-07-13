require 'rails_helper'

describe StaticPagesController do
  it 'should contain the team section' do
    get :index
    expect(response.status).to eq(200)
    expect(response.body).to include('Our Amazing Team')
  end


end