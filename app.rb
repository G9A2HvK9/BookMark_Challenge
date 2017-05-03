require 'sinatra/base'
require './model/link'

class App < Sinatra::Base

  get "/" do
    redirect("/links")
  end

  get '/links' do
    @links = Link.all
    erb(:links)
  end

  get '/links/new' do
    erb(:new_link)
  end

  post '/links' do
    Link.create(name: params[:name], url: params[:url])
    redirect('/links')
  end


  run! if app_file == $0
end
