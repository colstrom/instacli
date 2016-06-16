require 'contracts'

module InstaCLI
  # Usage documentation for --help
  module Help
    include ::Contracts::Core
    include ::Contracts::Builtin

    def header(*args)
      "NAME:\n\t#{[program, *args].join ' '} - #{description}"
    end

    Contract None => String
    def commands
      ['COMMANDS:', *objects].join("\n\t")
    end

    Contract RespondTo[:to_sym] => String
    def commands(o)
      ['COMMANDS:', *methods(o)].join("\n\t")
    end

    Contract RespondTo[:to_sym], RespondTo[:to_sym] => String
    def usage(o, m)
      "USAGE:\n\t #{[program, o, m, *parameters(o, m)].join(' ')}"
    end

    def help(*args)
      if args.length < 2
        [header(*args), commands(*args)].join("\n\n")
      else
        [header(*args), usage(*args)].join("\n\n")
      end
    end

    private

    Contract None => String
    def program
      File.basename $PROGRAM_NAME
    end

    Contract None => String
    def description
      'CommandLine Interface'
    end
  end
end
