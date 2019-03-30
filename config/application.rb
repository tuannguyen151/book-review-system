require_relative "boot"
require "rails/all"

Bundler.require(*Rails.groups)

module RubyHtBookReviewSystem
  class Application < Rails::Application
    config.load_defaults 5.2
    config.generators.system_tests = nil
    config.i18n.load_path += Dir[Rails.root.join 'config',
      'locales', '**', '*.{rb,yml}']
    config.i18n.available_locales = %i(en vi)
    config.i18n.default_locale = :en
    config.autoload_paths += %w(#{config.root}/app/models/ckeditor)
    config.middleware.use I18n::JS::Middleware
  end
end
