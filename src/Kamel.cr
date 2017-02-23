require "kemal"
require "ecr"
require "dotenv"
require "crecto"
require "db"
require "pg"

require "./Kamel/models/*"
require "./Kamel/controllers/*"
require "./Kamel/*"

module Kamel
	
	# Dotenv.load
	
	# Run Kamel
	Kemal.run

end
