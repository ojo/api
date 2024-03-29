class Admin::NewsItemsController < Admin::BaseController
  before_action :set_news_item, only: [:crop]
  load_and_authorize_resource

  # GET /news_items
  # GET /news_items.json
  def index
    scope = case params[:category]
            when nil
              NewsItem
            when 'Uncategorized'
              NewsItem.where(category: nil)
            else
              NewsItem.where(category: params[:category])
            end
    @news_items = scope.order(created_at: :desc).all
  end

  # GET /news_items/1
  # GET /news_items/1.json
  def show
  end

  # GET /news_items/new
  def new
    @news_item = NewsItem.new
  end

  # GET /news_items/1/edit
  def edit
  end

  # POST /news_items
  # POST /news_items.json
  def create
    @news_item = NewsItem.new(news_item_params)

    respond_to do |format|
      if @news_item.save
        format.html { redirect_to [:admin, @news_item], notice: 'News item was successfully created.' }
        format.json { render :show, status: :created, location: @news_item }
      else
        format.html { render :new }
        format.json { render json: @news_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /news_items/1
  # PATCH/PUT /news_items/1.json
  def update
    respond_to do |format|
      if @news_item.update(news_item_params)
        format.html { redirect_to [:admin, @news_item], notice: 'News item was successfully updated.' }
        format.json { render :show, status: :ok, location: @news_item }
      else
        format.html { render :edit }
        format.json { render json: @news_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /news_items/1
  # DELETE /news_items/1.json
  def destroy
    @news_item.destroy
    respond_to do |format|
      format.html { redirect_to admin_news_items_url, notice: 'News item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def crop
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_news_item
      @news_item = NewsItem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def news_item_params
      params.require(:news_item).permit(
        :title, :subtitle, :body, :photo, :straphead, :photo_caption, :state, :category,

        # these are required for gem 'papercrop' cropping
        :photo_original_w, :photo_original_h, :photo_box_w, :photo_aspect,
        :photo_crop_x, :photo_crop_y, :photo_crop_w, :photo_crop_h
      )
    end
end
