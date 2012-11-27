require "quicksync/version"
require "core_ext"

class QuickSync

  attr_reader :settings, :from, :to, :exclude, :include, :copy_options
  attr_writer :settings, :from, :to, :exclude, :include, :copy_options
  
  def initialize(*args)
    puts "QuickSync.initialize method called"
    @config = default_config
  end

  def initialized?
    @initialized || false
  end

  def default_config
    puts "QuickSync.default_config method called"
    yaml = {}
    config_dir = File.join(Pathname.new(Dir.pwd).parent,"config")
    file = File.join(config_dir,".quicksync")
    return YAML::load(File.open(file)) if File.exists? file

  end
  
  def config(*args)
    puts "QuickSync.config method called"
    @config = config.merge(args)
  end
  
  def config
    return @config
  end
  
  def quicksync_test(*args)
   puts "quicksync_test() function called args=#{args}"
  end

  def generate_cmd(*args)
    raise ArgumentError.new("from and to are both required values, either set as arguments for this method or set first") if from.blank? || to.blank?
    puts "QuickSync.generated_cmd() method called with args=#{args}"

  end

  def push_to(*args)
    puts "QuickSync.push_to() method called with args=#{args}"
  end

  def pull_from(*args)
   puts "QuickSync.pull_from() method called with args=#{args}"
  end

  def do_rsync(*args)

   puts "QuickSync.do_rsync() method called with args=#{args}"
  end

end

