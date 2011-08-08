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
        video_link: "http://www.youtube.com",
        dimensions: "1' x 2' x 3'",
        completion_year: 2010,
        for_sale: true,
        price: 1.38,
        price_currency: "usd",
        quantity: 1
      )
      puts "  #{w.title}".green
    end
    puts divider

  end
end