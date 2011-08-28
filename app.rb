# coding: utf-8
require 'rubygems'
require 'bundler'
require 'pp'
require 'pathname'
require 'yaml'
Bundler.require

configure do
  ENV['RACK_ENV'] ||= 'development'
  YAML::ENGINE.yamler = 'syck'
  enable :sessions
  use Rack::Flash
  set :haml, :format => :html5, :escape_html => true
  Pathname.glob('models/*').each do |m|
    load m
  end
end

before do
  # mongoid
  Mongoid.add_language('ja')
  Mongoid.load! File.join('config', 'mongoid.yml')
end

get '/' do
  messages = Message.order_by(:created_at).all
  haml :index, :locals => {:messages => messages}
end

post '/' do
  message = Message.create(:message => params[:message])
  if !message.persisted?
    flash[:errors] = message.errors
  end
  redirect '/'
end