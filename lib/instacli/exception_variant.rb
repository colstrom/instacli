module InstaCLI
  # Contract matching any descendant of Exception
  class ExceptionVariant
    def self.valid?(object)
      object.ancestors.include? Exception
    end
  end
end
