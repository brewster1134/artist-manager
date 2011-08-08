Factory.define :user do |u|
  u.sequence(:username)   { |n| "user#{n}" }
  u.sequence(:email)      { |n| "email#{n}@example.com" }
  u.password              "password"
  u.password_confirmation { |u| u.password }
end

Factory.define :work do |w|
  w.sequence(:title)  { |n| "Title #{n}" }
end
