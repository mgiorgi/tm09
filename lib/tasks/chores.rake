namespace :chores do
  
  task :hourly => :environment do
    chore("Hourly") do
      system "touch /home/lokkedc/ejecute.txt"
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
