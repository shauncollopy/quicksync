module QuickSync
  class CLI
    require 'highline'

    def self.run
      qsync = QuickSync::RSync.new
      config = qsync.config
      
      from = {}
      to = {}
      options={}
      copy_strategy = :push_to;
      choose do |menu|
        menu.prompt = "Copy strategy?  "
        copy_strategy = menu.choice
      end
      from[:dir]      = ui.ask("from[:dir]?  ")     { |q| q.default = config[:from][:dir] }
      from[:host]     = ui.ask("from[:host]?  ")    { |q| q.default = config[:from][:host] }
      from[:user]     = ui.ask("from[:user]?  ")    { |q| q.default = config[:from][:user] }
      to[:dir]        = ui.ask("to[:dir]?  ")       { |q| q.default = config[:to][:dir] }
      to[:host]       = ui.ask("to[:host]?  ")      { |q| q.default = config[:to][:host] }
      to[:user]       = ui.ask("to[:user]?  ")      { |q| q.default = config[:to][:user] }
      options[:include]       = ui.ask("includes?  ")      { |q| q.default = config[:include].join(',') }
      options[:exclude]       = ui.ask("excludes?  ")      { |q| q.default = config[:exclude].join(',') }
      options[:copy_options]  = ui.ask("copy options?  ")  { |q| q.default = config[:copy_options].join(',') }
      
      config[:settings].each do |key, value|
        qsync.settings[key.to_sym] = ui.ask("settings[#{key.to_s}]?  ") { |q| q.default = "#{value}" }
      end

      logger.debug "CLI.run from=#{from}"
      logger.debug "CLI.run to=#{to}"
      logger.debug "CLI.run copy_options=#{options[:copy_options]}"
      logger.debug "CLI.run include=#{options[:include]}"
      logger.debug "CLI.run exclude=#{options[:exclude]}"
      logger.debug "CLI.run settings=#{options[:settings]}"
      

    end

    def self.ui
      @ui ||= HighLine.new
    end

    def env_var(var)
      if ! ENV[var].nil? && ! ENV[var].empty?
        return ENV[var]
      else
        return ""
      end
    end

    def env_var_bool(var)
      return to_boolean(ENV[var])
    end
  end

end