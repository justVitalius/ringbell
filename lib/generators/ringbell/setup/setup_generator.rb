require 'rails/generators'
require 'rails/generators/migration'

module Ringbell
  class SetupGenerator < Rails::Generators::Base
    include Rails::Generators::Migration

    desc "Sets up the required table for the gem"
    source_root File.expand_path('..', __FILE__)

    def create_migration_file
      migration_template 'migration.rb', 'db/migrate/create_ringbell_notifications.rb'
    end

    def self.next_migration_number(dirname)
      if ActiveRecord::Base.timestamped_migrations
        Time.now.utc.strftime("%Y%m%d%H%M%S")
      else
        "%.3d" % (current_migration_number(dirname) + 1)
      end
    end
  end
end