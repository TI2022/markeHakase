class ItemsController < ApplicationController
  skip_before_action :authenticate_user!
  skip_before_action :authenticate_staff!, only: [:index, :show, :search]
  before_action :set_q, only: [:index, :search]

  def index
    #  初めてページを訪問したログインユーザーにはカートが作られます
    if current_user && !current_user.cart.present?
      cart = current_user.build_cart
      cart.save
    end
    # @items = Item.page(params[:page]).per(6).order(updated_at: "DESC")
    # @q.resultはソート機能です
    @items = @q.result.page(params[:page]).per(6).order(updated_at: "DESC")
  end

  def search
    @results = @q.result
  end

  def show
    @item = Item.find(params[:id])
  end

  def new
    @item = Item.new
    
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      flash[:success] = "#{@item.name} の登録に成功しました"
      redirect_to items_path(current_user)
    else
      flash[:danger] = "新規商品の登録に問題がありました"
      render :new
    end
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      flash[:success] = "#{@item.name} の情報を更新しました。"
      redirect_to items_path(current_user)
    else
      flash[:danger] = "商品情報の編集に問題がありました"
      render :edit
    end
  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy
    flash[:success] = "#{@item.name} を削除しました。"
    redirect_to items_path(current_user)
  end

  private
    def item_params
      params.require(:item).permit(:name, :price, :description, :stock, :image)
    end

    def set_q
      @q = Item.ransack(params[:q])
    end
    
end

