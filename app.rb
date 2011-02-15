require 'rubygems'
require 'sinatra'
require 'builder'
require 'rest_client'
require 'dm-core'
require 'dm-postgres-adapter'
require 'dm-validations'

DataMapper.setup(:default, ENV['DATABASE_URL'])

class Entrant
  include DataMapper::Resource

  property :number, String, :required => true

  validates_uniqueness_of :number
end

helpers do
  def add_entrant(number)
    Entrant.create(:number => number)
  end
end

post '/voice' do
  add_entrant(params['From'])
  builder :welcome
end