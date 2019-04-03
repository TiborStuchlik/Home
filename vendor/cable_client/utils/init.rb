require "active_record"

puts "init..."

path = File.dirname(__dir__)
cfg_file_name = "hub.cfg"
db_file_name = "database.yml"
cfg_file_path = path + "/cfg/" + cfg_file_name
db_file_path = path + "/cfg/" + db_file_name

def db_configuration(cfg)
   db_configuration_file = (cfg)
   YAML.load(File.read(db_configuration_file))
end

class Configuration < ActiveRecord::Base

end

print "Checking configuration file... "
if File.file?( cfg_file_path)
  puts "Ok"
else
  puts "None"
end

ActiveRecord::Base.establish_connection(db_configuration(db_file_path)["development"])
c = Configuration.new
c.name = "test"
c. save