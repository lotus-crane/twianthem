class PagesController < ApplicationController
  before_action :login_required, only: [:timeline, :tweet]
  include Common
  require 'twitter'

  def tweet
    client = client_new
    client.update(params[:text])
    redirect_to home_path
  end

  def timeline
    client = client_new
    @user = client.user
    @tweets = client.home_timeline(include_entities: true)
  end
  def index
  end

  def show
  end
  
  def timeline
  end
end
