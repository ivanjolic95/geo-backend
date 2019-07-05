module Result
  class Base
    attr_reader :payload
    attr_accessor :errors

    def initialize(payload = nil)
      @payload = payload
      @errors = []
    end

    def success?
      raise NotImplementedError
    end

    def failure?
      raise NotImplementedError
    end
  end
end
