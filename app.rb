require 'rubygems'
require 'sinatra'
require 'builder'
require 'rest_client'

post '/voice' do
  builder :welcome
end