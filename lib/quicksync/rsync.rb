

module QuickSync
  class RSync

    attr_accessor :settings, :from, :to, :exclude, :include, :copy_options, :run_method
    attr_reader :config, :logger
    
    def initialize
      @logger = QuickSync.LoggerInstance
      @logger.level = QuickSync::Logger::TRACE
      logger.debug "QuickSync.initialize method called"
      set_config
      
    end
    
    def copy_options_to_s
      puts "copy_options_to_s =#{copy_options}"
      return copy_options.map{ |o| "--#{o}"}.join(' ')
    end
    
    def include_to_s
      if include.any?
        return include.map { |i| "--include=\"#{i}\"" }.join(' ')
       end
    end
    
    def exclude_to_s
      if exclude.any?
        return exclude.map { |e| "--exclude=\"#{e}\"" }.join(' ')
      end
    end
    
    def config
      @config
    end

    def set_config
      logger.debug "QuickSync.set_config method called"
      config_dir = File.join(Pathname.new(File.dirname(__FILE__)).parent.parent,"config")
      config_file = File.join(config_dir,"quicksync_config.rb")
      load "#{config_file}"
      @config = $default_config

    end

    def set_options(from_v,to_v,options)
   
      if from_v.nil? || from_v.empty?
        raise ArgumentError, ":from can not be empty"
      end

      if to_v.nil? || to_v.empty?
        raise ArgumentError, ":to can not be empty"
      end

      @from = from_v == String ? config[:from].merge({:dir=>from_v}): config[:from].merge(from_v)
      @to = to_v == String ? config[:to].merge({:dir=>to_v}): config[:to].merge(to_v)
      @exclude =  options.length > 0 && ! options[:exclude].nil? ? options[:exclude]: config[:exclude]
      @include =  options.length > 0 && ! options[:include].nil? ? options[:include]: config[:include]
      @copy_options = options.length > 0 && ! options[:copy_options].nil? ? config[:copy_options].merge(options[:copy_options]): config[:copy_options]
      @settings = options.length > 0 && ! options[:settings].nil? ? config[:settings].merge(options[:settings]): config[:settings]
      @run_method = config[:run_method]
      
      logger.debug "QuickSync.set_options:"
      logger.debug " from=#{from}"
      logger.debug " to=#{to}"
      logger.debug " exclude=#{exclude}"
      logger.debug " include=#{include}"
      logger.debug " copy_options=#{copy_options}"
      logger.debug " settings=#{settings}"

    end
    
    def pull_from(from,to,options={})
      logger.debug "RSync.pull_from: from=#{from}, to=#{to}"
      set_options(from,to,options)
      # if from[:dir] does not exist then abort as there is nothing to do
      cmd = generate_cmd
      
      if run_method == :execute
        # run the actual command before returning it
      end
      puts "RSync.pull_from: cmd=#{cmd}"
      return cmd
    end
    
    def run_on
      if is_local(from[:host])  && is_local(to[:host]) 
        return :local
      elsif is_local(from[:host])  && is_remote(to[:host])
        return :local
      elsif is_remote(from[:host])  && is_remote(to[:host])
        return :remote
      elsif is_remote(from[:host])  && is_local(to[:host])
        return :remote
      else
        return :local
      end
    end
    
    def is_local(the_host)
      if ! the_host.nil?  && ! the_host.empty?  && the_host.include?("local")
        return true
      else
        return false
      end
    end
    
    def is_remote(the_host)
      if ! the_host.nil?  && ! the_host.empty?  && ! the_host.include?("local")
        return true
      else
        return false
      end
    end
    
    def from_to_s 
      
    logger.debug "RSync.from_to_s: from=#{from}"
      if ! from[:host].nil?  && ! from[:host].empty?  && ! from[:host].include?("local")
        return from[:user]+"@"+from[:host] + ":" + from[:dir]
      else 
        return from[:dir]
      end
    end
    
    def to_to_s 
      val = to[:dir]
      if ! to[:host].nil?  && ! to[:host].empty?  && ! to[:host].include?("local")
        val = to[:user]+"@"+to[:host] + ":" + to[:dir]
      else 
        return to[:dir]
      end
    end


    def generate_cmd
      logger.debug "QuickSync.generated_cmd: method called"
     
      cmd = "#{settings[:rsync_app]} #{copy_options_to_s}"
      cmd << " #{include_to_s}" if include.any?
      cmd << " #{exclude_to_s}" if exclude.any?
      cmd << " #{from_to_s}/ #{to_to_s}"
      
      return cmd
    end

  end

end