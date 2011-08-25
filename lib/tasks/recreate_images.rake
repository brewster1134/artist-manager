desc "Recreate Images"
task :recreate_images => :environment do
  WorkImage.all.each{|w| w.image.recreate_versions!}
end
