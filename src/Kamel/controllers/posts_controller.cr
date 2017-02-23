require "crecto"

module PostController 
    extend self

    def index_items
        query = Crecto::Repo::Query
            .order_by("posts.id DESC")
        dataset = Crecto::Repo.all(Models::Post, query)
        dataset.as(Array) unless dataset.nil?

        puts "Number of Items are: #{Crecto::Repo.aggregate(User, :count, :id)}"

    end

    def save_new_item(env)
        data = Models::Post.new

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

        puts "/nThe item was successfully ADDED. ID:#{changeset.instance.id}/n"
    end

    def edit_an_item(env)
        id = env.params.url["id"]
        data = Crecto::Repo.get(Models::Post, id)
    end

    def save_edited_item(env)
        id = env.params.url["id"]
        data = Crecto::Repo.get(Models::Post, id)

        if data
            data.title = env.params.body["post_title"]
            data.content = env.params.body["post_content"]

            changeset = Crecto::Repo.update(data)
            puts "Changeset is INVALID!" if changeset.valid? == false
            puts "Changeset errors are: #{changeset.errors }" if !changeset.errors.empty?
            puts "/nThe item was successfully UPDATED. ID:#{changeset.instance.id}/n"
        end
    end

    def delete_an_item(env)
        id = env.params.url["id"]
        query = Crecto::Repo::Query
            .where(id: id)

        changeset = Crecto::Repo.delete_all(Models::Post, query)
        puts "Changeset is INVALID!" if changeset.valid? == false
        puts "Changeset errors are: #{changeset.errors }" if !changeset.errors.empty?
        puts "/nThe item was successfully DELETED. ID:#{changeset.instance.id}/n"
    end

end
