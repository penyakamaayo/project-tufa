class PublicController < ApplicationController
  skip_before_action :authenticate_user!, :only => [:index]
  # load_and_authorize_resource
  # authorize_resource class: false
  def index
  end

  def show
  end
end