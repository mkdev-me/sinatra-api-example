require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/json'
set :database, { adapter: 'sqlite3', database: 'transactions.sqlite' }

class Transaction < ActiveRecord::Base
  validates :amount, presence: true
end

post "/transactions" do
  transaction = Transaction.create(params[:transaction])
  json status: :ok, transaction: transaction
end

get "/transactions" do
  json transactions: Transaction.all
end

get "/transactions/:id" do
  json transaction: Transaction.find(params[:id])
end

delete "/transactions/:id" do
  transaction = Transaction.find(params[:id])
  transaction.destroy!
  json status: :ok
end

put "/transactions/:id" do
  transaction = Transaction.find(params[:id])
  transaction.update_attributes(params[:transaction])
  json status: :ok, transaction: transaction
end
