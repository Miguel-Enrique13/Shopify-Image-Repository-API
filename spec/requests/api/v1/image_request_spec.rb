require 'rails_helper'

describe 'Images-' do
  it 'upload one image' do
    user = create(:user)
    image_params = {
      title: 'this the Title',
      description: 'Ultimate Description',
      price: 5.99,
      inventory: 7,
      privacy: 'private'
    }

    headers = { 'CONTENT_TYPE' => 'application/json' }
    # Get token
    post '/api/v1/authenticate', headers: headers, params: JSON.generate(email: user.email, password: user.password)

    token = JSON.parse(response.body, symbolize_names: true)[:auth_token]

    headers['Authorization'] = token

    post '/api/v1/one_image', headers: headers, params: JSON.generate(image_params)

    created_image = Image.last

    expect(response).to be_successful
    expect(created_image.title).to eq(image_params[:title])
    expect(created_image.description).to eq(image_params[:description])
    expect(created_image.price).to eq(image_params[:price])
    expect(created_image.inventory).to eq(image_params[:inventory])
    expect(created_image.privacy).to eq(image_params[:privacy])
  end

  it 'upload many images' do
    user = create(:user)
    image_files = [1, 2, 3, 4, 5, 6, 7, 8]

    headers = { 'CONTENT_TYPE' => 'application/json' }
    # Get token
    post '/api/v1/authenticate', headers: headers, params: JSON.generate(email: user.email, password: user.password)

    token = JSON.parse(response.body, symbolize_names: true)[:auth_token]

    headers['Authorization'] = token

    post '/api/v1/bulk_images', headers: headers, params: JSON.generate(image_files: image_files)

    expect(Image.all.count).to eq(8)
  end

  it 'delete one image' do
    user = create(:user)
    image_params = {
      title: 'this the Title',
      description: 'Ultimate Description',
      price: 5.99,
      inventory: 7,
      privacy: 'private'
    }

    headers = { 'CONTENT_TYPE' => 'application/json' }
    # Get token
    post '/api/v1/authenticate', headers: headers, params: JSON.generate(email: user.email, password: user.password)
    token = JSON.parse(response.body, symbolize_names: true)[:auth_token]
    headers['Authorization'] = token
    post '/api/v1/one_image', headers: headers, params: JSON.generate(image_params)

    expect(Image.all.count).to eq(1)

    image = Image.last

    delete '/api/v1/one_image', headers: headers, params: JSON.generate(image_id: image.id)

    expect(Image.all.count).to eq(0)
  end

  it 'should not be able to delete someone else image' do
    user1 = create(:user)
    user2 = create(:user)
    image_params = {
      title: 'this the Title',
      description: 'Ultimate Description',
      price: 5.99,
      inventory: 7,
      privacy: 'private'
    }

    headers = { 'CONTENT_TYPE' => 'application/json' }
    # Get token
    post '/api/v1/authenticate', headers: headers, params: JSON.generate(email: user1.email, password: user1.password)
    token1 = JSON.parse(response.body, symbolize_names: true)[:auth_token]

    post '/api/v1/authenticate', headers: headers, params: JSON.generate(email: user2.email, password: user2.password)
    token2 = JSON.parse(response.body, symbolize_names: true)[:auth_token]

    headers['Authorization'] = token1
    post '/api/v1/one_image', headers: headers, params: JSON.generate(image_params)

    image = Image.last

    headers['Authorization'] = token2
    delete '/api/v1/one_image', headers: headers, params: JSON.generate(image_id: image.id)

    expect(JSON.parse(response.body, symbolize_names: true)[:errors]).to eq('Unauthorized User')
  end

  it 'delete bulk images' do
    user = create(:user)
    image_files = [1, 2, 3, 4, 5, 6, 7, 8]

    headers = { 'CONTENT_TYPE' => 'application/json' }
    # Get token
    post '/api/v1/authenticate', headers: headers, params: JSON.generate(email: user.email, password: user.password)
    token = JSON.parse(response.body, symbolize_names: true)[:auth_token]
    headers['Authorization'] = token
    post '/api/v1/bulk_images', headers: headers, params: JSON.generate(image_files: image_files)

    expect(Image.all.count).to eq(8)

    all_images = []
    Image.last(8).each { |image| all_images << image.id }

    delete '/api/v1/bulk_images', headers: headers, params: JSON.generate(image_id: all_images)

    expect(Image.all.count).to eq(0)
  end
end
