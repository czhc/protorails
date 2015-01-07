module ApplicationHelper
  def verifier
    @@verifier = ActiveSupport::MessageVerifier.new(Settings.secret)
  end
end
