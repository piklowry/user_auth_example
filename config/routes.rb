Rails.application.routes.draw do
  get "login" => "sessions#new"
  get "logout" => "sessions#destroy"
  resources :users
  resources :sessions, only: [:new, :create, :destroy]

  resources :wishlists do 
    resources :items 
    # makes routes like 'wishlists/1/items', which should have a page with all the items for the wishlist with id 1,the => pattern 'wishlists/:wishlitst_id/items/:id'...will know that all items belond to this wishlist
  end
end
