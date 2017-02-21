require "pg"
require "dotenv"

Dotenv.load!

size = 100

host = ENV["host"]
port = ENV["port"]
database = ENV["database"]
user = ENV["user"]
password = ENV["password"]

uri = "postgres://#{user}:#{password}@#{host}:#{port}/#{database}"

puts uri

db = DB.open uri
begin
    puts "Connecting to database"

    table_size = db.scalar "select count(*) from posts;"

    puts "Current table size is #{table_size} rows"

ensure
  db.close
end
