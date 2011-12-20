namespace :dev_db do

  desc "Raise an error if in production environment."
  task :not_production, [:override] do |t, args|
    raise "Not on production you dingus! #{args[:override].inspect}" if Rails.env.production? && args[:override] != "true" 
  end

  desc "Drop, create, migrate then seed the development database."
  task :seed, [:override] => [ 'environment', 'dev_db:not_production', 'db:migrate', 'db:seed'] do |t, args|
    require 'timeout'
    puts divider = "--------------------------".blue
    Series.destroy_all
    Work.destroy_all

    # Delete directories
    FileUtils.rm_rf "#{Rails.root}/public/uploads"
    puts "UPLOADED IMAGES DELETED".green
    puts divider

    work_attributes = {
      description: Lorem::Base.new(:paragraphs, 3).output,
      video_link: ["http://www.youtube.com/watch?v=kYgIlZCYClw", ""].sample,
      dimensions: ["1' x 2' x 3'", ""].sample,
      completion_year: [Date.today.year, ""].sample,
      for_sale: [true, false].sample,
      price: [1.38, 0].sample,
      price_currency: "usd",
      quantity: (0..10).to_a.sample,
      tag_list: ["Paintings", "Pictures", "Video", "Sculptures"].sample
    }

    puts "SERIES".green
    5.times do |i|
      s = Factory(:series,
        description: Lorem::Base.new(:paragraphs, 3).output,
      )
      (1..3).to_a.sample.times do
        s.works << Factory(:work, work_attributes)
      end
      puts "  #{s.title}".green
      s.works.each do |w|
        puts "    #{w.title}".green
      end
    end
    puts divider

    puts "WORK".green
    10.times do |i|
      w = Factory(:work, work_attributes)
      puts "  #{w.title}".green
    end
    puts divider
    
    puts "Would you like to add images? This can take a few minutes... (y/n)"
    
    add_images = Timeout::timeout( 5 ) { STDIN.gets.chomp } rescue 'y'
    
    if add_images == 'y'
      puts "UPLOADING RANDOM IMAGES".green
      
      Work.all.each do |w|
        images = (1..3).to_a.sample
        images.times do
          Factory(:work_image, :work => w)
        end
        puts "#{images} Images added to #{w.title}"
      end
    end
    puts divider
    puts "DONE!".blue
    puts divider
  end

end