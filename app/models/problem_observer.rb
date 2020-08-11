require 'my_logger'
class ProblemObserver < ActiveRecord::Observer
  def after_update(record)
  # use the MyLogger instance method to retrieve the single instance/object of the class
  @logger = MyLogger.instance
  # use the logger to log/record a message about the updated car
  @logger.logInformation("###############Observer Demo:#")
  @logger.logInformation("+++ ProblemObserver: The Problem for
      #{record.user.email} has been updated to:
      - subject: #{record.subject}
      - topic: #{record.topic}
      - question #{record.question} ")
    @logger.logInformation("##############################")
  end
end
