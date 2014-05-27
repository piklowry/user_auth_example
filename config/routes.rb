Rails.application.routes.draw do
  get "login" => "sessions#new"
  get "logout" => "sessions#destroy"

  resources :users
  resources :sessions, only: [:new, :create, :destroy]

  resources :wishlists do 
    resources :items 
    # makes routes like 'wishlists/1/items', which should have a page with all the items for the wishlist with id 1,the => pattern 'wishlists/:wishlitst_id/items/:id'...will know that all items belond to this wishlist
  end


  get "something" => "wishlists#new" #this would go to localhost3000/something and hit the the wishlists/new actin
  get "github_auth" => "github#authenticate"

  get "github_auth/callback" => "github#callback" 
  post "create_gist" => "github#create_gist" 
end
