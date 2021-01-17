Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      post 'authenticate', to: 'authentication#authenticate'

      post 'one_image', to: 'images#upload_one_image'
      post 'bulk_images', to: 'images#upload_bulk_images'

      delete 'one_image', to: 'images#delete_one_image'
      delete 'bulk_images', to: 'images#delete_bulk_images'
    end
  end
end
