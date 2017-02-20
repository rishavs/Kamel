require "crecto"

module Kamel

    class Post < Crecto::Model

      	schema "posts" do
            field :title, 		String,
            # field :is_link, 	Bool,
            # field :link, 		String,
            field :content,		String,
            # field :author_name,	String,
            # field :is_viewable, Bool,
            # field :is_approved, Bool,
            field :is_deleted,  Bool
    	end
    	
    	validate_required [:title]
    end

	get "/p/:id" do 
		#{title}
		#{content}
		# TODO
	end

	get "/p/new" do 
	  	render "src/Kamel/views/new_post.ecr", "src/Kamel/views/layouts/base.ecr"
	end

	post "/p/create" do |env|


		data = Post.new

 		data.title = env.params.body["post_title"]
 		data.content = env.params.body["post_content"]
 		
 		changeset = Crecto::Repo.insert(data)
		puts changeset.valid? # false
		puts changeset.errors # {:field => "name", :message => "is invalid"}
		puts changeset.changes # {:name => "123", :age => 123}

 		puts data
 		puts data.title

 		puts "jhinga la la"
	end



	#---------------------------------------------------------------------------------------













	# Redirect browser
	get "/foo" do |env|
	  	# important stuff like clearing session etc.
	 	env.redirect "/bar" # redirect to /bar page
	end
	get "/bar" do 
		"type foo get bar"
	end


	get "/error" do |env|
	    env.response.status_code = 403
	end


	error 404 do
	    "This is a customized 404 page."
	end

	error 403 do
	    "Access Forbidden!"
	end


	get "/:name" do |env|
	  	name = env.params.url["name"]
	  	render "src/Kamel/views/hello.ecr", "src/Kamel/views/layouts/base.ecr"
	end

	get "/" do
		"Hello World!"
	end

end