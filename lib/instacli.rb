
require_relative 'instacli/cli'
require_relative 'instacli/exception_variant'
require_relative 'instacli/help'
require_relative 'instacli/demuxing'

# Convenience Wrapper
module InstaCLI
  def self.new(*args)
    InstaCLI::CLI.new(*args)
  end
end
