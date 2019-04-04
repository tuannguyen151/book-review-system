class Admin::HomeController < ApplicationController
  before_action :admin?

  def index; end
end
