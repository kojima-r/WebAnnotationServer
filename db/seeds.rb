# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
      
#params.require(:label).permit(:name, :fullname, :description)
require "csv"

CSV.foreach('db/ca_birds.csv') do |row|
	  Label.create(:name => row[0], :fullname => row[1], :description => row[2])
end

