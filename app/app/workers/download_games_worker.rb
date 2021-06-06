# This is a sample worker so you can copy/paste initially.
class SampleWorker
  include Sidekiq::Worker

  def perform(id)
    begin
      record = ::SampleModel.find(id)
    rescue ActiveRecord::RecordNotFound
      logger.warn "Record id ##{id} doesn't exist"
      return
    end

    instance = AppName::SampleClass.new(record)
    instance.run
  end
end
