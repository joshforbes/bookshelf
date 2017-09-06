require('token_strategy')

Warden::Strategies.add(:token, TokenStrategy)

Rails.application.config.middleware.use Warden::Manager do |manager|
  manager.default_strategies :token
  manager.failure_app = Auth::UnauthorizedController
end