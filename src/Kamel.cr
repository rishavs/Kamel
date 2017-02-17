require "kemal"
require "ecr"
require "db"
require "pg"



before_get "/posts" do |env|
	DB.open "postgres://wguyczml:Z1CKsVDby2pp154JcMm_eSnev6v_ayFR@fizzy-cherry.db.elephantsql.com:5432/wguyczml" do |db|
		db.query "select title, content from posts" do |result|
		    result.each do
			    title = result.read(String)
			    content = result.read(String)
			    puts "#{title}" 
			    puts "#{content}"
			end
		end
	end
end

get "/posts" do 
	#{title}
	#{content}
end

#----------------------
# Redirect browser
get "/foo" do |env|
  	# important stuff like clearing session etc.
 	env.redirect "/bar" # redirect to /bar page
end

# Redirect browser
get "/bar" do 
	"type foo get bar"
end

#----------------------
get "/error" do |env|
    env.response.status_code = 403
end


error 404 do
    "This is a customized 404 page."
end

error 403 do
    "Access Forbidden!"
end

#----------------------
get "/:name" do |env|
  	name = env.params.url["name"]
  	render "src/Kamel/views/hello.ecr", "src/Kamel/views/layouts/base.ecr"
end

#----------------------
get "/" do
	"Hello World!"
end


Kemal.run