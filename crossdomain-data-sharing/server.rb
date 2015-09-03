#!/usr/bin/env ruby

require 'sinatra'
require 'json'

# set :bind, 'example.com'
set :port, '80'

get '/data.jsonp' do
  # headers 'Access-Control-Allow-Origin' => 'http://example.com'
  content_type 'text/javascript'

  data = {
    text: 'Data from JS'
  }

  "jsData = #{data.to_json}"
end

get '/ajax.js' do
  headers 'Access-Control-Allow-Origin' => 'http://example.com'
  content_type :json
  {
    text: 'Data from AJAX'
  }.to_json
end

get '/event.js' do
  # headers 'Access-Control-Allow-Origin' => 'http://example.com'
  content_type 'text/javascript'

  data = {
    text: 'Data from a JavaScript event'
  }

  "function dataViaEvent(){ var event = new CustomEvent('dataLoaded', { detail: #{data.to_json} }); document.dispatchEvent(event); };" +
  "function dataViaEventFromAJAX(){ $.get('http://example.net/ajax.js', function(data) { var event = new CustomEvent('dataLoaded', { detail: data }); document.dispatchEvent(event); });};"
end

get '/' do
  erb :index
end
