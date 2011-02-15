require 'rubygems'
require 'sinatra'
require 'builder'
require 'rest_client'
require 'dm-core'
require 'dm-postgres-adapter'
require 'dm-migrations'
require 'dm-validations'

DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite3://#{Dir.pwd}/development.db")

class Entrant
  include DataMapper::Resource

  property :id, Serial
  property :number, String, :required => true

  validates_uniqueness_of :number
end

DataMapper.auto_upgrade!

post '/voice' do
  Entrant.create(:number => params['From'])
  builder :welcome
end