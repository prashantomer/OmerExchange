Rails.application.routes.draw do
  devise_for :members, controllers: {
    confirmations:        'members/confirmations',
    passwords:            'members/passwords',
    registrations:        'members/registrations',
    sessions:             'members/sessions',
    unlocks:              'members/unlocks',
    omniauth_callbacks:   'members/omniauth_callbacks'
  }
  resources :messages
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'messages#index'

  mount ActionCable.server => '/cable'
end
