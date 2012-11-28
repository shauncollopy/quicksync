require 'highline'

module QuickSync

  module CLI
    
    def CLI.run
      to = {}
      from = {}
      # basic input
      from[:dir]        = ask("from[:dir]?  ")
      from[:host]        = ask("from[:host]?  ")
      from[:user]        = ask("from[:user]?  ")
      
      to[:dir]        = ask("to[:dir]?  ")
      to[:host]        = ask("to[:host]?  ")
      to[:user]        = ask("to[:user]?  ")
      
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