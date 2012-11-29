require "core_ext"
require "quicksync/version"
require "quicksync/logger"
require 'quicksync/rsync'
require 'quicksync/cli'

config_dir = File.join(Pathname.new(File.dirname(__FILE__)).parent,"config")
config_file = File.join(config_dir,"quicksync_config.rb")
load "#{config_file}"

