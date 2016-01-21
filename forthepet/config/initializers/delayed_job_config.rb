# config/initializers/delayed_job_config.rb
Delayed::Worker.destroy_failed_jobs = false
# Delayed::Worker.sleep_delay = 60
# Delayed::Worker.max_attempts = 3
# Delayed::Worker.max_run_time = 5.minutes
# Delayed::Worker.read_ahead = 10
# Delayed::Worker.default_queue_name = 'default'
Delayed::Worker.delay_jobs = !Rails.env.test?
Delayed::Worker.logger = Logger.new(File.join(Rails.root, 'log', 'delayed_job.log'))

if Rails.env.development?
  module Delayed
    module Backend
      module ActiveRecord
        class Job
          class << self
            alias_method :reserve_original, :reserve
            def reserve(worker, max_run_time = Worker.max_run_time)
              previous_level = ::ActiveRecord::Base.logger.level
              ::ActiveRecord::Base.logger.level = Logger::WARN if previous_level < Logger::WARN
              value = reserve_original(worker, max_run_time)
              ::ActiveRecord::Base.logger.level = previous_level
              value
            end
          end
        end
      end
    end
  end
end
