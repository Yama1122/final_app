Rails.application.routes.draw do
  root to:'products#index'
  resources 'searches', only: :index
end
