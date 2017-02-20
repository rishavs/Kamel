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

end