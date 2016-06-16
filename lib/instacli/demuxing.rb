require 'contracts'

module InstaCLI
  # Mixin for routing by invocation (like busybox)
  module Demuxing
    include ::Contracts::Core
    include ::Contracts::Builtin

    Contract None => String
    def invoked_as
      File.basename $PROGRAM_NAME
    end

    def execute(*args)
      return STDERR.puts help(invoked_as, args[1..-1]) if %w(--help -h).include?(args.first)

      m, *rest = *args

      begin
        STDOUT.puts method(invoked_as, m).call(*rest)
      rescue *rescues
        STDERR.puts help(invoked_as, *args)
      end
    end
  end
end
