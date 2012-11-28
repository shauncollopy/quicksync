require "quicksync/version"
require "core_ext"
require "logger"

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

  def generate_cmd(*args)
    raise ArgumentError.new("from and to are both required values, either set as arguments for this method or set first") if from.blank? || to.blank?
    puts "QuickSync.generated_cmd() method called with args=#{args}"

    if options[:flags].nil? || options[:flags].empty?
      options[:flags] = rsync_default_flags
    end
    options_str = options[:flags].map{|o| "--#{o}"}.join(' ')
    source_type = options[:source_type].to_sym
    destination_type = options[:destination_type].to_sym
    run_on = :local

    cmd = "rsync #{options_str}"
    if include.any?
      cmd << " " + include.map { |e| "--include=\"#{e}\"" }.join(' ')
    end
    if exclude.any?
      cmd << " " + exclude.map { |e| "--exclude=\"#{e}\"" }.join(' ')
    end

    if source_type == :local  && ! File.exists?("#{source}")
      logger.important "  do_rsync: source does not exist on local host, source=#{source}"
    return false
    elsif source_type == :remote  && ! file_exists?("#{source}")
      logger.important "  do_rsync: source does not exist on remote host, source=#{source}"
    return false
    end

    if source_type == :local && destination_type == :local
      source = "#{source}"
      destination = "#{destination}"
      run_on = :local
    elsif source_type == :local && destination_type == :remote
      source = "#{source}"
      destination = "#{user}@#{domain}:#{destination}"
      run_on = :local
    elsif source_type == :remote && destination_type == :remote
      source = "#{source}"
      destination = "#{destination}"
      run_on = :remote
    elsif source_type == :remote && destination_type == :local
      source = "#{user}@#{domain}:#{source}"
      destination = "#{destination}"
      run_on = :local
    end

    cmd << " #{source}/ #{destination}"
    puts "QuickSync.do_rsync() method called with args=#{args}"
    if run_on==:remote
      return capture "#{cmd}"
    else
      return run_locally "#{cmd}"
    end
  end

end

