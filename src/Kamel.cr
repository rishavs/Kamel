require "kemal"
require "ecr"
require "db"
require "pg"
require "dotenv"
require "crecto"

require "./Kamel/*"

module Kamel

	# Setup Kamel
	Dotenv.load!

	puts ENV["password"]
	
	# Run Kamel
	Kemal.run

end
