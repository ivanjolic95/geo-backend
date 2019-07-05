module Result
  class Failure < Base
    def success?
      false
    end

    def failure?
      true
    end

    def add_error(error)
      errors << error
      self
    end
  end
end
