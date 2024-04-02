class RatesController < ApplicationController
  def index
    @rates = Rate.where(user_id: current_user.id).order(created_at: :desc)
  end
end