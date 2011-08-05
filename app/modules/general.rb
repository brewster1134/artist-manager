module General
  
  def generate_token
    SecureRandom.base64(16).tr('+/=', 'xyz')
  end
  
end