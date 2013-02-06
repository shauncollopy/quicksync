test_path = "/users/shaun/Dropbox/dtg/development"
require "#{test_path}/ruby-core-ext/lib/core_ext"
require "#{test_path}/quicksync/lib/quicksync/version"
require "#{test_path}/quicksync/lib/quicksync/logger"
require "#{test_path}/quicksync/lib/quicksync/rsync"
require "#{test_path}/quicksync/lib/quicksync/cli"
require "etc"

module QuickSync
  
  def self.Config
    @config ||= QuickSync.LoadConfig
  end
  
  def self.LoadConfig
    
    home_path = Etc.getpwuid.dir
    gem_path = File.join(Pathname.new(File.dirname(__FILE__)).parent,"config")
    search_paths = [home_path, gem_path]
    yaml_filename = "quicksync.yaml"
    yaml_file= "#{gem_path}/#{yaml_filename}"
    search_paths.each { |p|
      file = "#{p}/#{yaml_filename}"
      if File.exists?(file)
        yaml_file = file
        break
      end
    }
    return YAML::load( File.open( yaml_file ) )
  end
end

