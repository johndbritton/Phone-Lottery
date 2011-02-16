require 'rubygems'
require 'sinatra'
require 'builder'
require 'dm-core'
require 'dm-postgres-adapter'
require 'dm-migrations'
require 'dm-validations'

DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite3://#{Dir.pwd}/development.db")

class Entrant
  include DataMapper::Resource

  property :id, Serial
  property :number, String, :required => true
  property :eligible, Boolean, :default => true

  validates_uniqueness_of :number
end

DataMapper.auto_upgrade!

post '/entrant' do
  Entrant.create(:number => params[:From])
  builder :entrant
end

post '/host' do
  builder :host
end

post '/winner' do
  eligible_entrants = Entrant.all(:eligible => true)
  eligible_entrants_count = eligible_entrants.count
  unless eligible_entrants_count < 1 then
    @winner = eligible_entrants[rand(eligible_entants_count)]
    @winner.eligible = false
    @winner.save
    builder :winner
  else
    builder :none
  end
end

post '/clear' do
  if params[:Digits] == '9'
    Entrant.all(:eligible => true).destroy
    builder :cleared
  else
    builder :host
  end
end

get '/count' do
  @count = Entrant.count
  haml :count
end