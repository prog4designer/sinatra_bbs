# coding: utf-8
require 'rubygems'
require 'bundler'
Bundler.require

configure do
  MESSAGES = []
end

get '/' do
  haml :index, :locals => {:messages => MESSAGES}
end

post '/' do
  MESSAGES << params[:message]
  redirect '/'
end