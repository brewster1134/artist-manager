namespace :dev_db do

  desc "Raise an error if RAILS_ENV is production"
  task :not_production do
    raise "Not on production you dingus!" if Rails.env.production?
  end

  desc "Drop, create, migrate then seed the development database"
  task :seed => [ 'environment', 'dev_db:not_production', 'db:drop', 'db:migrate', 'db:seed'] do
    divider = "--------------------------".blue

    # Delete directories
    # FileUtils.rm_rf "#{Rails.root}/public/uploads"
    # puts "UPLOAD IMAGES DELETED".green
    # puts divider

    # Create a user for each role
    puts "WORK".green
    10.times do |i|
      w = Factory(:work,
        description: Lorem::Base.new(:paragraphs, 3).output,
        video_link: ["http://www.youtube.com", ""].sample,
        dimensions: ["1' x 2' x 3'", ""].sample,
        completion_year: [Date.today.year, ""].sample,
        for_sale: [true, false].sample,
        price: 1.38,
        price_currency: "usd",
        quantity: (0..10).to_a.sample,
        tag_list: ["Paintings", "Pictures", "Video", "Sculptures"].sample
      )
      puts "  #{w.title}".green
    end
    puts divider

  end
end