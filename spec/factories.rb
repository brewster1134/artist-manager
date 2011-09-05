Factory.define :user do |u|
  u.sequence(:username)   { |n| "user#{n}" }
  u.sequence(:email)      { |n| "email#{n}@example.com" }
  u.password              "password"
  u.password_confirmation { |u| u.password }
end

Factory.define :series do |w|
  w.sequence(:title)  { |n| "Series #{n}" }
end

Factory.define :work do |w|
  w.sequence(:title)  { |n| "Title #{n}" }
end

Factory.define :work_image do |wi|
  wi.work   { Factory(:work) }
  wi.image  { File.open(Dir.glob("#{Rails.root}/vendor/assets/images/stock/*").sample) }
end
