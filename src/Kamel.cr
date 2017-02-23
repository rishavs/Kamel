require "kemal"
require "ecr"
require "dotenv"
require "pg"
require "crecto"


require "./Kamel/models/*"
require "./Kamel/controllers/*"
require "./Kamel/*"


	
# Dotenv.load
	
	# Run Kamel
Kemal.run


