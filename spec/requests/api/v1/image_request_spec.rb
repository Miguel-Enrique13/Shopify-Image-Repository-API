require 'rails_helper'

describe "Images-" do
  it "upload one image" do
    user = create(:user)
    image_params = {
      title: "this the Title",
      description: "Ultimate Description",
      price: 5.99,
      inventory: 7,
      privacy: "privacy",
    }

    headers = {'CONTENT_TYPE' => 'application/json'}
    #Get token
    post '/api/v1/authenticate', headers: headers, params: JSON.generate(email: user.email, password: user.password)

    token = JSON.parse(response.body,symbolize_names: true)[:auth_token]

    headers["Authorization"] = token

    post '/api/v1/one_image', headers: headers, params: JSON.generate(image_params)

    created_image = Image.last

    expect(response).to be_successful
    expect(created_image.title).to eq(image_params[:title])
    expect(created_image.description).to eq(image_params[:description])
    expect(created_image.price).to eq(image_params[:price])
    expect(created_image.inventory).to eq(image_params[:inventory])
    expect(created_image.privacy).to eq(image_params[:privacy])
  end

  it "upload many images" do
    user = create(:user)
    image_files = [1,2,3,4,5,6,7,8]

    headers = {'CONTENT_TYPE' => 'application/json'}
    #Get token
    post '/api/v1/authenticate', headers: headers, params: JSON.generate(email: user.email, password: user.password)

    token = JSON.parse(response.body,symbolize_names: true)[:auth_token]

    headers["Authorization"] = token

    post '/api/v1/bulk_images', headers: headers, params: JSON.generate(image_files: image_files)

    expect(Image.all.count).to eq(8)

  end
end
