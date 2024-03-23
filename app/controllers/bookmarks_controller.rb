class BookmarksController < ApplicationController
  before_action :require_login

  def create
    @list = List.find(params[:list_id])
    current_user.bookmarked_lists << @list
    redirect_to @list
  end

  def destroy
    @list = List.find(params[:list_id])
    current_user.bookmarked_lists.delete(@list)
    redirect_to @list
  end
end