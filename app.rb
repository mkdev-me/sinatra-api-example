require 'sinatra'
require 'sinatra/activerecord'
set :database, { adapter: 'sqlite3', database: 'transactions.sqlite' }

class Transaction < ActiveRecord::Base
  validates :amount, presence: true
end
