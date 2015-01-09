module Protorails
  module Utility
    def self.make_token
      SecureRandom.hex(20)
    end
  end
end
