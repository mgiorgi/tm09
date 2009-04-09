class Admin::BaseController < ApplicationController  
  before_filter :authenticate
  #require_role 'admin'

  ActiveScaffold.set_defaults do |config| 
    config.ignore_columns.add [:created_at, :updated_at]
  end  

  protected
    def authenticate
      authenticate_or_request_with_http_basic do |username, password|
        username == ADMIN_USER && password == ADMIN_PASS
      end
    end

    # TODO: resource_controller generates wrong helper names in namespaced controllers
    # See the Admin::* controllers to see how this is used
    def get_class_name
      self.class.to_s.gsub(/^Admin::(.*)Controller$/, '\1').singularize.underscore.downcase
    end
end
