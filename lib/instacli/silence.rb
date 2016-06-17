module InstaCLI
  # Suppress output
  module Silence
    def execute(*args)
      return STDERR.puts help(*args[1..-1]) if %w(--help -h).include?(args.first)

      o, m, *rest = *args

      begin
        method(o, m).call(*rest)
      rescue *rescues
        STDERR.puts help(*args)
      end
    end
  end
end
