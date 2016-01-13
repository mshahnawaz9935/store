class ItemsController < ApplicationController
before_filter :authenticate_user!
before_filter :ensure_admin, :only => [:new, :create, :edit, :destroy]
before_action :set_item, only: [:show, :edit, :update, :destroy]  
  # GET /items
  # GET /items.json
  def index
    @k=session[:k]
	if(@k=="phone")
	@items = Item.where("category = 'Phones'")
	session[:k]="a"
	else if(@k=="shoes")
	@items = Item.where("category = 'Shoes'")
	session[:k]="a"
	else
	@items= Item.all
	end
	end
  end
  def phone
  session[:k]="phone"
  redirect_to :action => :index
  end
  
  def shoes
  session[:k]="shoes"
  redirect_to :action => :index
  end

  # GET /items/1
  # GET /items/1.json
  def show
  end

  # GET /items/new
  def new
    @item = Item.new
  end

  # GET /items/1/edit
  def edit
  end

  # POST /items
  # POST /items.json
  def ensure_admin
  unless current_user && current_user.admin?
  render :text => "Access Error Message", :status => :unauthorized
  end
  end
  def create
    @item = Item.new(item_params)

    respond_to do |format|
      if @item.save
        format.html { redirect_to @item, notice: 'Item was successfully created.' }
        format.json { render :show, status: :created, location: @item }
      else
        format.html { render :new }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /items/1
  # PATCH/PUT /items/1.json
  def update
    respond_to do |format|
      if @item.update(item_params)
        format.html { redirect_to @item, notice: 'Item was successfully updated.' }
        format.json { render :show, status: :ok, location: @item }
      else
        format.html { render :edit }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.json
  def destroy
    @item.destroy
    respond_to do |format|
      format.html { redirect_to items_url, notice: 'Item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def item_params
      params.require(:item).permit(:title, :description, :price, :image_url, :category, :brand)
    end
end
