OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '628283833950163', '064db5e7ffa986ec11b6f75b60af5ea2',
           :scope => 'email,user_birthday,read_stream', :display => 'page'
end