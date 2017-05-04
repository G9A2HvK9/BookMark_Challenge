ENV['RACK_ENV'] ||= 'development'

require 'sinatra/base'
require_relative './model/link'
require_relative './model/tag'
require_relative './data_mapper_setup'

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
    link = Link.create(name: params[:name], url: params[:url])
    new_tags = params[:tags].split(", ")
    new_tags.each do |new_tag|
      tag_to_add = Tag.first_or_create(tag: new_tag)
      link.tags << tag_to_add
      link.save
    end
    redirect('/links')
  end

  get '/tags/:tag' do
    tag = Tag.first(tag: params[:tag])
    @links = tag ? tag.links : []
    erb(:links)
  end


  run! if app_file == $0
end
