class ApplicationInteractor
  include Interactor

  private

  def error(message)
  context.fail!(error: message)
  end
end
