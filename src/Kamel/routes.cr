require "crecto"

module Kamel

    class Post < Crecto::Model

      	schema "posts" do
            field :title, 			String
            field :is_link, 		Bool
            field :link, 			String
            field :content,			String
            field :author_username,	String
            field :is_viewable, 	Bool
            field :is_approved, 	Bool
            field :is_deleted,  	Bool
            field :last_read_at,	Time
    	end
    	
    	validate_required [:title]
    end

    get "/p/index" do |env|
		query = Crecto::Repo::Query
		  	.order_by("posts.id DESC")

		dataset = Crecto::Repo.all(Post, query)
		dataset.as(Array)

	  	render "src/Kamel/views/posts/index_posts.ecr", "src/Kamel/views/base.ecr"
	end

	get "/p/:id" do |env|
	  	id = env.params.url["id"]
	  	data = Crecto::Repo.get(Post, id)
	  	render "src/Kamel/views/posts/show_post.ecr", "src/Kamel/views/base.ecr"
	end

	get "/p/new" do 
	  	render "src/Kamel/views/posts/new_post.ecr", "src/Kamel/views/base.ecr"
	end

	post "/p/new/creating" do |env|
		data = Post.new

 		data.title = env.params.body["post_title"]
 		data.is_link = false
 		data.link = nil
 		data.content = env.params.body["post_content"]
 		data.author_username = "some guy"
 		data.is_viewable = true
 		data.is_approved = true
 		data.is_deleted = false
 		data.last_read_at = Time.new(2016, 2, 15, 10, 20, 30)

 		changeset = Crecto::Repo.insert(data)
		puts "Changeset is INVALID!" if changeset.valid? == false
		puts "Changeset errors are: #{changeset.errors }" if !changeset.errors.empty?

 		puts "/nThe item was successfully added to the DB with ID:#{changeset.instance.id}/n"

	 	env.redirect "/p/#{changeset.instance.id}" 
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

	get "/" do
		"Hello World!"
	end

end