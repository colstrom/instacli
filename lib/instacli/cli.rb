#!/usr/bin/env ruby

require 'contracts'
require_relative 'exception_variant'

module InstaCLI
  # Instant CLI - just add Objects!
  class CLI
    include ::Contracts::Core
    include ::Contracts::Builtin

    Contract None => ArrayOf[ExceptionVariant]
    def rescues
      [ArgumentError]
    end

    Contract Maybe[HashOf[Symbol, Object]] => InstaCLI::CLI
    def initialize(**mapping)
      @mapping = mapping
      self
    end

    Contract None => ArrayOf[Symbol]
    def objects
      @mapping.keys
    end

    Contract RespondTo[:to_sym] => Bool
    def object?(o)
      object.include? o.to_sym
    end

    Contract RespondTo[:to_sym] => Object
    def object(o)
      @mapping.fetch(o.to_sym) { Object.new }
    end

    Contract RespondTo[:to_sym] => ArrayOf[Symbol]
    def methods(o)
      object(o).methods - Object.methods
    end

    Contract RespondTo[:to_sym], RespondTo[:to_sym] => Bool
    def method?(o, m)
      methods(o).include? m.to_sym
    end

    Contract RespondTo[:to_sym], RespondTo[:to_sym] => Any
    def method(o, m)
      raise ArgumentError unless method? o, m
      object(o).method(m)
    end

    Contract RespondTo[:to_sym], RespondTo[:to_sym] => ArrayOf[String]
    def parameters(o, m)
      method(o, m)
        .parameters
        .map { |p| p.first == :req ? "<#{p.last}>" : "[#{p.last}]" }
    end

    def help(*)
      ''
    end

    def execute(*args)
      return STDERR.puts help(*args[1..-1]) if %w(--help -h).include?(args.first)

      o, m, *rest = *args

      begin
        STDOUT.puts method(o, m).call(*rest)
      rescue *rescues
        STDERR.puts help(*args)
      end
    end
  end
end
