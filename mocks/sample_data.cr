require "pg"
require "faker"
require "dotenv"

puts Faker::Name.name

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
    puts "Connected to database"

    table_exists = db.scalar "select count(*) from pg_tables where schemaname='public' and tablename = 'posts';"
    puts table_exists
    if table_exists == 0 
        puts "Table doesn't exists. creating table..."

        db.exec "CREATE TABLE posts(
            id serial primary key,
            title character varying(255),
            is_link boolean default true,
            link character varying(255),
            content text,
            author_username character varying(255),
            is_viewable boolean default false,
            is_approved boolean default false,
            is_deleted boolean default false,
            created_at timestamp default current_timestamp,
            updated_at timestamp,
            last_read_at timestamp
        );"
        puts "Table created. Populating with sample data. Datasize = #{size}"

    else
        puts "Table exists. Populating with sample data. Datasize = #{size}"
    end



    (1..size).each do |i|
        db.exec "INSERT INTO posts (title, is_link, link, content, author_username) VALUES
            ('#{Faker::Lorem.sentence}', 'true', '#{Faker::Internet.url}', '#{Faker::Lorem.paragraph(50, true, 50)}', '#{Faker::Internet.user_name}');"
        if i % 20 == 0 
            puts "20 records inserted..."
        end
    end

    puts "Sample data Populated!"

    table_size = db.scalar "select count(*) from posts;"
    puts "Current table size is #{table_size} rows"




    # db.query "select name, age from contacts order by age desc" do |rs|
    #     rs.each do
    #         # ... perform for each row in the ResultSet
    #     end
    # end
ensure
  db.close
end



# # Creates connection with the default postgres db
# conn = PG.connect("#{PG_PATH}/postgres")

# database_exists? = conn.exec(%{
#     SELECT CAST(1 AS integer)
#     FROM pg_database
#     WHERE datname=$1
# }, [DB_NAME]).to_hash.empty? ? false : true

# if !database_exists?
#     # Creates the notes_db database with UTF8 encoding and close the connection
#     puts "Creating database: #{DB_NAME}..."
#     conn.exec("CREATE DATABASE #{DB_NAME} ENCODING 'UTF8';")
#     conn.close

#     # Creates connection with the newly created db
#     puts "Connecting database: #{DB_NAME}..."
#     conn = PG.connect("#{PG_PATH}/#{DB_NAME}")

#     # Creates the notes table in the newly created database
#     puts "Creating notes table in #{DB_NAME}..."
#     conn.exec(%{
#         CREATE TABLE notes (
#             id                    SERIAL PRIMARY KEY,
#             title             TEXT NOT NULL,
#             content         TEXT NOT NULL,
#             created_at    TIMESTAMP WITH TIME ZONE NOT NULL,
#             updated_at    TIMESTAMP WITH TIME ZONE NOT NULL
#         );
#     })
#     puts "Process finished succesfully"
# else
#     puts "The database #{DB_NAME} already exists!!"
# end

# puts "Closing connection..."
# conn.close