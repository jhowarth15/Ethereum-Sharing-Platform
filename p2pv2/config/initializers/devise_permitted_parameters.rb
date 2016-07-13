# config/initializers/devise_permitted_parameters.rb

module DevisePermittedParameters

  extend ActiveSupport::Concern

  included do
    before_filter :configure_permitted_parameters
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :username << :name_first << :name_last
    devise_parameter_sanitizer.for(:account_update) << :username << :name_first << :name_last
  end


end

DeviseController.send :include, DevisePermittedParameters
