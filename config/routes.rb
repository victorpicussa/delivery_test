Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get 'parse', controller: 'parse', action: 'parser'
  post 'create', controller: 'delivery', action: 'create'
end
