class ItemsController < ApplicationController
  #skip_before_action :authenticate_user!
  skip_before_action :authenticate_staff!
  before_action :set_q, only: [:index, :search]

  def index
    #  初めて商品ページを訪問したログインユーザーにはカートが作られます
    if !current_user.cart.present?
      cart = current_user.build_cart
      cart.save
    end

    # @items = Item.page(params[:page]).per(5).order(id: "ASC")
    @items = @q.result.page(params[:page]).per(5).order(id: "DESC")
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
    
    if @item = Item.create(item_params)
      flash[:success] = "#{@item} の登録に成功しました"
    redirect_to items_path(current_user)
    else
      flash[:danger] = "#{@item} の作成に問題がありました"
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

