require 'rubygems'
require 'sinatra'
require 'builder'
require 'rest_client'

DataMapper.setup(:default, ENV['DATABASE_URL'])

class Entrant
  include DataMapper::Resource

  property :number, String, :required => True

  validates_uniqueness_of :number
end

helpers do
  def add_entrant(number)
    e = Entrant.new
    e.number = number
    e.save
  end
end

post '/voice' do
  add_entrant(params['From'])
  builder :welcome
end