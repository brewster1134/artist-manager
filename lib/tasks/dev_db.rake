namespace :dev_db do

  desc "Drop, create, migrate then seed the development database"
  task :seed, :force do |t, args|
    raise "Not on production you dingus!" if Rails.env.production? && args[:force] != "true"
    Rake::Task[:environment].invoke
    Rake::Task['db:drop'].invoke
    Rake::Task['db:migrate'].invoke
    Rake::Task['db:seed'].invoke

    divider = "--------------------------".blue

    # Delete directories
    FileUtils.rm_rf "#{Rails.root}/public/uploads"
    puts "UPLOAD IMAGES DELETED".green
    puts divider

    work_attributes = {
      description: Lorem::Base.new(:paragraphs, 3).output,
      video_link: ["http://www.youtube.com", ""].sample,
      dimensions: ["1' x 2' x 3'", ""].sample,
      completion_year: [Date.today.year, ""].sample,
      for_sale: [true, false].sample,
      price: 1.38,
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

  end
end