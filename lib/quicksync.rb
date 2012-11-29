require "core_ext"
require "quicksync/version"
require "quicksync/logger"
require 'quicksync/rsync'
require 'quicksync/cli'
require 'etc'

search_paths = [Etc.getpwuid.dir, File.join(Pathname.new(File.dirname(__FILE__)).parent,"config")]
file_name = ".quicksync_config"
config_file = ""
search_paths.each { |p| 
  if File.exists?("#{p}/#{file_name}") 
    config_file = "#{p}/#{file_name}"
    break
  end
}


load "#{config_file}"
