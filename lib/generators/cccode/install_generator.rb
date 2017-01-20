require 'rails/generators/base'

module Cccode
  module Generators
    
    class InstallGenerator < Rails::Generators::Base
      include Rails::Generators::Migration
      source_root File.expand_path('../../templates', __FILE__)

      desc "Creates a Cccode initializer and copy locale files to your application."
      def hi
        puts "hi am Cccode installer running fine ..."
      end
      
      desc "add the migrations"
      def self.next_migration_number(path)
        unless @prev_migration_nr
          @prev_migration_nr = Time.now.utc.strftime("%Y%m%d%H%M%S").to_i
        else
          @prev_migration_nr += 1
        end
        @prev_migration_nr.to_s
      end
      
      def copy_migrations
        copy_migration 'create_country_codes'
      end
      
      protected

      def copy_migration(filename)
        if self.class.migration_exists?("db/migrate", "#{filename}")
          say_status("skipped", "Migration #{filename}.rb already exists")
        else
          migration_template "#{filename}.rb", "db/migrate/#{filename}.rb"
        end
      end
      
    end
  end
end
