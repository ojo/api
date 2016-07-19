class Admin::HomeController < Admin::BaseController
  def index
    authorize! :go, :home
  end
end
