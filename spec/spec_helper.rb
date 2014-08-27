require 'with_model'

RSpec.configure do |config|
  config.extend WithModel
end

ActiveRecord::Base.establish_connection adapter:'sqlite3', database: ':memory:'
ActiveRecord::Migration.verbose = false

require File.expand_path('../../lib/generators/ringbell/setup/migration.rb', __FILE__)
CreateRingbellNotifications.migrate(:up)
