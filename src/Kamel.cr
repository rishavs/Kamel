require "kemal"
require "ecr"


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
  	render "src/web/views/hello.ecr", "src/web/layouts/layout.ecr"
end

#----------------------
get "/" do
	"Hello World!"
end


Kemal.run