module Routes

    get "/p/index" do
		PostController.index_items
	  	render "src/Kamel/views/posts/index_posts.ecr", "src/Kamel/views/base.ecr"
	end

	get "/p/new" do 
	  	render "src/Kamel/views/posts/new_post.ecr", "src/Kamel/views/base.ecr"
	end

	post "/p/new" do |env|
		PostController.save_new_item(env)
	 	env.redirect "/p/index" 
	end

	get "/p/:id" do |env|
	  	render "src/Kamel/views/posts/show_post.ecr", "src/Kamel/views/base.ecr"
	end

	get "/p/:id/edit" do |env|
		PostController.edit_an_item(env)
	  	render "src/Kamel/views/posts/edit_post.ecr", "src/Kamel/views/base.ecr"
	end	

	patch "/p/:id" do |env|
		PostController.save_edited_item(env)
	 	env.redirect "/p/#{changeset.instance.id}" 
	end

	delete "/p/:id" do |env|
		PostController.delete_an_item(env)
	 	env.redirect "/p/index" 
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