require 'rspec'
require 'pry'

# Models
Dir[File.expand_path "lib/*.rb"].each do |file|
  require file
end
