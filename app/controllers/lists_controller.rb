class ListsController < ApplicationController
  before_action :require_login

	def new
    @list = List.new
    render layout: false
  end

	def index
    @lists = List.where(user_id: current_user.id).order(created_at: :desc)
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

  def show
    session[:visited] = nil
    @list = List.find(params[:id])    
    @artists = @list.artists.order(created_at: :desc)
  end

	def edit
		@list = List.find(params[:id])
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
    params.require(:list).permit(:name)
  end
end
