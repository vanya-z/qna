def set_omniauth_facebook
  OmniAuth.config.test_mode = true 
  OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new(provider: 'facebook',uid: '12345', info: { email: 'test@example.com' })
end

def set_omniauth_vkontakte
  OmniAuth.config.test_mode = true 
  OmniAuth.config.mock_auth[:vkontakte] = OmniAuth::AuthHash.new(provider: 'vkontakte',uid: '12345', info: { email: 'test@example.com' })
end

def set_omniauth_twitter
  OmniAuth.config.test_mode = true 
  OmniAuth.config.mock_auth[:twitter] = OmniAuth::AuthHash.new(provider: 'twitter',uid: '12345', info: { name: 'foo' })
end

def set_omniauth_github
  OmniAuth.config.test_mode = true 
  OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new(provider: 'github',uid: '12345', info: { name: 'foo' })
end