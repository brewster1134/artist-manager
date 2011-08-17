env = Sprockets::Environment.new(Rails.root)
env.register_engine '.haml', Tilt::HamlTemplate
