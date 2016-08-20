class Admin::NewsCategoriesController < Admin::BaseController
  load_and_authorize_resource

  # GET /news_categories
  def index
    @news_categories = NewsCategory.order(priority: :asc).all
  end

  # GET /news_categories/1
  def show
  end

  # GET /news_categories/new
  def new
    @news_category = NewsCategory.new
  end

  # GET /news_categories/1/edit
  def edit
  end

  # POST /news_categories
  def create
    @news_category = NewsCategory.new(news_category_params)

    if @news_category.save
      redirect_to [:admin, @news_category], notice: 'News category was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /news_categories/1
  def update
    if @news_category.update(news_category_params)
      redirect_to [:admin, @news_category], notice: 'News category was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /news_categories/1
  def destroy
    @news_category.destroy
    redirect_to admin_news_categories_url, notice: 'News category was successfully destroyed.'
  end

  private
    # Only allow a trusted parameter "white list" through.
    def news_category_params
      params.require(:news_category).permit(:name, :description, :priority)
    end
end
