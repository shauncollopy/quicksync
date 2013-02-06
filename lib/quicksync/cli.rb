module QuickSync
  class CLI
   
    require 'highline'

    def self.run

      $logger.debug "CLI.run: function called"
      qsync = QuickSync::RSync.new
      config = $default_options
      
      from = {}
      to = {}
      options={}
      settings = {}
      copy_strategy = :push_to;
      
      ui.choose do |menu|
        menu.prompt = "Copy strategy?  "
        copy_strategy = menu.choices(:pull_from, :push_to) 
      end
      from[:dir]      = ui.ask("from[:dir]?  ")     { |q| q.default = config[:from][:dir] }
      from[:host]     = ui.ask("from[:host]?  ")    { |q| q.default = config[:from][:host] }
      from[:user]     = ui.ask("from[:user]?  ")    { |q| q.default = config[:from][:user] }
      to[:dir]        = ui.ask("to[:dir]?  ")       { |q| q.default = config[:to][:dir] }
      to[:host]       = ui.ask("to[:host]?  ")      { |q| q.default = config[:to][:host] }
      to[:user]       = ui.ask("to[:user]?  ")      { |q| q.default = config[:to][:user] }
      options[:include]       = ui.ask("includes?  ", lambda { |str| str.split(/,\s*/) })      { |q| q.default = config[:include].join(',')}
      options[:exclude]       = ui.ask("excludes?  ", lambda { |str| str.split(/,\s*/) })    { |q| q.default = config[:exclude].join(',') }
      options[:copy_options]  = ui.ask("copy options?  ", lambda { |str| str.split(/,\s*/) })  { |q| q.default = config[:copy_options].join(',') }
      
      config[:settings].each do |key, value|
        settings[key.to_sym] = ui.ask("settings[#{key.to_s}]?  ") { |q| q.default = "#{value}" }
      end
      options[:settings] = settings

      $logger.debug "CLI.run from=#{from}"
      $logger.debug "CLI.run to=#{to}"
      $logger.debug "CLI.run copy_options=#{options[:copy_options]}"
      $logger.debug "CLI.run include=#{options[:include]}"
      $logger.debug "CLI.run exclude=#{options[:exclude]}"
      $logger.debug "CLI.run settings=#{options[:settings]}"
      
      qs = QuickSync::RSync.new
      cmd = qs.pull_from(from,to,options)
      $logger.important "CLI.run: pull_from cmd=#{cmd}"

    end

    def self.ui
      @ui ||= HighLine.new
    end

    
  end

end