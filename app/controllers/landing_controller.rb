class LandingController < ApplicationController
  before_action :authenticate_admin!, only: [:index_admin]

  def index
  end

  def index_admin
  end

  def contact

  end
end
