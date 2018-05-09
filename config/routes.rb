Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :canvas, only: [:index, :show]
  mount ActionCable.server => '/cable'
end
