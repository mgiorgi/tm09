namespace :chores do
  
  task :hourly => :environment do
    chore("Hourly") do
      system "rm -rf /var/www/talleresdememoria/current/log/*"
    end
  end
  
  task :daily => :environment do
    chore("Daily") do
      # Your Code Here
    end
  end
  
  task :weekly => :environment do
    chore("Weekly") do
      # Your Code Here
    end
  end
  
  def chore(name)
    puts "#{name} Task Invoked: #{Time.now}"
    yield
    puts "#{name} Task Finished: #{Time.now}"
  end
end
