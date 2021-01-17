Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      post 'authenticate', to: 'authentication#authenticate'
      post 'one_image', to: 'images#one_image'
      post 'bulk_images', to: 'images#bulk_images'
    end
  end
end
