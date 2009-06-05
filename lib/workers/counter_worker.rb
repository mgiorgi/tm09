class CounterWorker < BackgrounDRb::MetaWorker
  set_worker_name :counter_worker
  def create(args = nil)
    logger.info 'Starting the CounterWorker'
  end

  def user_count(customer_id = nil)
    logger.info "Current User Count: #{User.count}"
  end
end
