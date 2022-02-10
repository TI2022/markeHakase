class EventsController < ApplicationController
    skip_before_action :authenticate_user!
    skip_before_action :authenticate_staff!, only: [:index, :show, :search]
    before_action :set_q, only: [:index, :search]
    
  def index
    #  初めてページを訪問したログインユーザーにはカートが作られます
    if current_user && !current_user.cart.present?
      cart = current_user.build_cart
      cart.save
    end
    @events = Event.page(params[:page]).per(6).order(updated_at: "DESC")
  end

  def search
    @results = @q.result
  end

  def show
    @event = Event.find(params[:id])
    
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    if @event.save
      flash[:success] = "#{@event.title}の登録に成功しました"
      redirect_to events_path(current_user)
    else
      flash[:danger] = "新規イベントの登録に問題がありました"
      render :new
    end
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    if @event.update(event_params)
      flash[:success] = "#{@event.title}の情報を更新しました"
      redirect_to events_path(current_user)
    else
      flash[:danger] = "新規イベントの編集に問題がありました"
      render :edit
    end
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    flash[:success] = "#{@event.title} を削除しました。"
    redirect_to events_path(current_user)
  end

  private
    def event_params
      params.require(:event).permit(:title, :category, :price, :stock, :image, :description, :location, :first_date, :last_date, :start_time, :end_time, :start_time_alt, :end_time_alt, :remaining_ticket_numbers, :status, :owner_id, :store_id)
    end

    def set_q
      @q = Event.ransack(params[:q])
    end
end
