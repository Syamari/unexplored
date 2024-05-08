class ListsController < ApplicationController
  include ApplicationHelper

  before_action :require_login

def index
  @list = List.new

  @lists = case params[:view]
           when 'public'
    List.includes(:artists).where(public: true)
           when 'bookmarked'
    current_user.bookmarked_lists.includes(:artists)
  else
    current_user.lists.includes(:artists)
           end
end

  def show
    session[:visited] = nil
    
    @list = List.includes(artists: { artist_genres: :genre }).find(params[:id])
    @artists = @list.artists.includes(:list_artists, artist_genres: :genre).order(created_at: :desc)
    @unique_genres = get_unique_genre_names(@list)
    session[:list_id] = @list.id
  end

  def new
    @list = List.new
    render layout: false
  end

  def edit
    @list = List.find(params[:id])
  end

  def create
    @list = List.new(list_params)
    @list.user_id = current_user.id

    if @list.save
      flash[:success] = 'リストを作成しました'
      redirect_to lists_path

    else
      respond_to do |format|
        format.turbo_stream do
              flash.now[:error] = "リストの作成に失敗しました"
              render turbo_stream: turbo_stream.replace("flash_message", partial: "shared/flash_message")
        end   
      end
    end
  end

  def update
    @list = List.find(params[:id])
    if @list.update(list_params)
      flash[:success] = 'リストを編集しました'
      redirect_to lists_path
    else
      respond_to do |format|
        format.turbo_stream do
              flash.now[:error] = "リストの編集に失敗しました"
              render turbo_stream: turbo_stream.replace("flash_message", partial: "shared/flash_message")
        end   
      end
    end
  end

  def destroy
    list = List.find(params[:id])
    list.destroy
    flash[:success] = 'リストを削除しました'
    redirect_to lists_path
  end

  private

  def list_params
    params.require(:list).permit(:name, :public)
  end
end
