OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '416429495139600', '91c58c1bae8f04cd4fda6dd05d9e084e', scope: 'email, publish_actions, publish_stream'
end