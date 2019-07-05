module Result
  class Success < Base
    def success?
      true
    end

    def failure?
      false
    end
  end
end
