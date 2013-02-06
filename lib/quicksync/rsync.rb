module QuickSync
  class RSync

    attr_accessor :src, :dest, :user, :host, :exclude, :include, :copy_options, :settings, :run_method, :run_on, :sync_types
    attr_reader :default_options, :logger, :sync_type, :config
    def initialize
      @logger = QuickSync.Logger
      @logger.level = QuickSync::Logger::INFO
      @default_options = QuickSync.Config
      @sync_types = @default_options[:sync_types]

    end

    def set_sync_type(sync_type)
      @sync_type = sync_type.to_sym
    end

    def src_fully_qualified
      
      if sync_type == :pull_from
        return "#{user}@#{host}:#{src}"
      else
        return src
      end
    end

    def dest_fully_qualified
      if sync_type == :push_to
        return "#{user}@#{host}:#{dest}"
      else
        return "#{dest}"
      end
    end

    def run_on
      logger.trace "run_on function called, :sync_type=#{sync_type}, sync_types[sync_type]=#{sync_types[sync_type]}"
      return sync_types[sync_type]
    end

    def pull_from(src,dest,options={})
      set_sync_type(__method__)
      return sync(src,dest,options)
    end

    def push_to(src,dest,options={})
      set_sync_type(__method__)
      return sync(src,dest,options)
    end

    def copy_local(src,dest,options={})
      set_sync_type(__method__)
      return sync(src,dest,options)
    end

    def copy_remote(src,dest,options={})
      set_sync_type(__method__)
      return sync(src,dest,options)
    end

    def sync(src,dest,options={})
      parse_options(src,dest,options)
      cmd = generate_cmd
      logger.trace "quicksync command:\n  #{cmd}"
      if run_method == :execute
        system(cmd)
      end

      return cmd
    end

    def from_compressed_file(src,dest,options={})

      parse_options(src,dest,options)
      cmd = "tar -C #{dest} -zxvf #{current_backup}/#{application}.tgz && "
      cmd += copy_remote(src,dest,options{})
      return cmd

    end

    def to_str
      out = "RSync.to_str:\n"
      out += "  :src=#{src}\n"
      out += "  :dest=#{dest}\n"
      out += "  :dest_fully_qualified=#{dest_fully_qualified}\n"
      out += "  :host=#{host}\n"
      out += "  :user=#{user}\n"
      out += "  :exclude=#{exclude.join(',')}\n" if ! exclude.nil?
      out += "  :include=#{include.join(',')}\n" if ! include.nil?
      out += "  :copy_options=#{copy_options.join(" --")}\n"
      out += "  :settings=#{settings}\n"
      out += "  :sync_type=#{sync_type}\n"
      out += "  :sync_types=#{sync_types}\n"
      out += "  :run_on=#{run_on}\n"
      out += "  :run_method=#{run_method}\n"
      return out
    end

    def parse_options(src,dest,options)

      if src.nil? || src.empty?
        raise ArgumentError, ":src can not be empty"
      end

      if dest.nil? || dest.empty?
        raise ArgumentError, ":dest can not be empty"
      end

      @src =  ( ! src.nil? && ! src.empty? ) ? src: default_options[:src]
      @dest = ( ! dest.nil? && ! dest.empty? ) ? dest: default_options[:dest]
      @host = ( ! host.nil? && ! host.empty? ) ? host: default_options[:host]
      @user = ( ! user.nil? && ! user.empty? ) ? user: default_options[:user]
      @exclude =  options.length > 0 && ! options[:exclude].nil? ? options[:exclude]: default_options[:exclude]
      @include =  options.length > 0 && ! options[:include].nil? ? options[:include]: default_options[:include]
      @copy_options =  options.length > 0 && ! options[:copy_options].nil? ? options[:copy_options]: default_options[:copy_options]
      @settings = options.length > 0 && ! options[:settings].nil? ? default_options[:settings].merge(options[:settings]): default_options[:settings]
      @run_method =  options.length > 0 && ! options[:run_method].nil? ? options[:run_method]: default_options[:run_method]

    # logger.important " parse_options: #{self.to_str}"

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

    def generate_cmd

      cmd = "#{settings[:rsync_app]} #{copy_options_to_s}"
      cmd << " #{include_to_s}" if !include.nil? && include.any?
      cmd << " #{exclude_to_s}" if !exclude.nil? && exclude.any?
      cmd << " #{src_fully_qualified}/ #{dest_fully_qualified}"
      return cmd
    end

  end

end