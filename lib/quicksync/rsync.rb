

module QuickSync
  class RSync

    attr_accessor :settings, :from, :to, :exclude, :include, :copy_options, :run_method
    attr_reader :default_options, :logger
    
    def initialize
      @logger = QuickSync.Logger
      @logger.level = QuickSync::Logger::TRACE
      @default_options = $default_options
      
    end
    
    def copy_options_to_s
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
    
    def default_options
      @default_options
    end

    def parse_options(from_v,to_v,options)
   
      if from_v.nil? || from_v.empty?
        raise ArgumentError, ":from can not be empty"
      end

      if to_v.nil? || to_v.empty?
        raise ArgumentError, ":to can not be empty"
      end
      
      logger.debug "QuickSync.parse_options: from class=#{from_v.class}"

      @from = from_v == String ? default_options[:from].merge({:dir=>from_v}): default_options[:from].merge(from_v)
      @to = to_v == String ? default_options[:to].merge({:dir=>to_v}): default_options[:to].merge(to_v)
      @exclude =  options.length > 0 && ! options[:exclude].nil? ? options[:exclude]: default_options[:exclude]
      @include =  options.length > 0 && ! options[:include].nil? ? options[:include]: default_options[:include]
      @copy_options = options.length > 0 && ! options[:copy_options].nil? ? default_options[:copy_options].concat(options[:copy_options]).uniq!: default_options[:copy_options]
      @settings = options.length > 0 && ! options[:settings].nil? ? default_options[:settings].merge(options[:settings]): default_options[:settings]
      @run_method = default_options[:run_method]
     
      logger.debug "QuickSync.parse_options:"
      logger.debug "  from=#{from}"
      logger.debug "  to=#{to}"
      logger.debug "  exclude=#{exclude}"
      logger.debug "  include=#{include}"
      logger.debug "  copy_options=#{copy_options}"
      logger.debug "  settings=#{settings}"

    end
    
    def pull_from(from,to,options={})
      parse_options(from,to,options)
      # if from[:dir] does not exist then abort as there is nothing to do
      cmd = generate_cmd
      logger.info "RSync.pull_from: run_method=#{run_method}"
      if run_method == :execute
        # run the actual command before returning it
        logger.info "RSync.pull_from: about to execute command"
        system(cmd)
        
      end
      logger.info "quicksync command:\n  #{cmd}"
      return cmd
    end
    
    def push_to(from,to,options={})
      parse_options(from,to,options)
      # if from[:dir] does not exist then abort as there is nothing to do
      cmd = generate_cmd
      logger.info "RSync.push_to: run_method=#{run_method}"
      if run_method == :execute
        # run the actual command before returning it
        logger.info "RSync.push_to: about to execute command"
        system(cmd)
        
      end
      logger.info "quicksync command:\n  #{cmd}"
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
      cmd << " #{include_to_s}" if !include.nil? && include.any?
      cmd << " #{exclude_to_s}" if !exclude.nil? && exclude.any?
      cmd << " #{from_to_s}/ #{to_to_s}"
      
      return cmd
    end

  end

end