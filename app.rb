require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/json'

set :database, { adapter: 'sqlite3', database: 'transactions.sqlite' }

class Transaction < ActiveRecord::Base
  validates :amount, presence: true
end

before do
  content_type :json
  headers 'Access-Control-Allow-Origin' => '*',
          'Access-Control-Allow-Methods' => ['OPTIONS', 'GET', 'POST'],
          'Access-Control-Allow-Headers' => 'Content-Type'
  begin
    params.merge! JSON.parse(request.env["rack.input"].read)
  rescue JSON::ParserError
    logger.error "Cannot parse request body."
  end
end

get "/transactions" do
  json Transaction.all
end

get "/transactions/:id" do
  json Transaction.find(params[:id])
end

delete "/transactions/:id" do
  transaction = Transaction.find(params[:id])
  transaction.destroy!
  json status: :ok
end

put "/transactions/:id" do
  transaction = Transaction.find(params[:id])
  transaction.update_attributes(params[:transaction])
  json status: :ok
end

options '/transactions' do
  200
end

post "/transactions" do
  puts params.inspect
  transaction = Transaction.create!(params[:transaction])
  json status: :ok, transaction: transaction
end
