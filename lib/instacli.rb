
require_relative 'instacli/cli'
require_relative 'instacli/exception_variant'
require_relative 'instacli/help'
require_relative 'instacli/demuxing'
require_relative 'instacli/silence'

# Convenience Wrapper
module InstaCLI
  def self.new(*args)
    InstaCLI::CLI.new(*args)
  end
end
