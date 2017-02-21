require "kemal"
require "ecr"
require "db"
require "pg"
require "dotenv"
require "crecto"

require "./Kamel/models/*"


require "./Kamel/*"

module Kamel

	# Run Kamel
	Kemal.run

end
