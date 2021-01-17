require 'rails_helper'

describe 'Users' do
  it 'Create User endpoint' do
    email = 'newuser@email.com'
    password = 'password'

    headers = { 'CONTENT_TYPE' => 'application/json' }

    post '/api/v1/create_user', headers: headers,
                                params: JSON.generate(email: email, password: password, password_confirmation: password)

    expect(User.last.email).to eq(email)
  end

  it 'Error when passwords do not match ' do
    email = 'newuser@email.com'
    password = 'password'

    headers = { 'CONTENT_TYPE' => 'application/json' }

    post '/api/v1/create_user', headers: headers,
                                params: JSON.generate(email: email, password: password, password_confirmation: 'blue')

    expect(JSON.parse(response.body,
                      symbolize_headers: true)['message']).to eq("Password confirmation doesn't match Password")
  end
end
