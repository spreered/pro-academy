class Admin::CategoriesController < Admin::BaseController 
  def index
    @categories = Category.all.order(id: :asc)
    @new_category = Category.new
  end

  def create
    @category = Category.new(category_params)
    unless @category.save
      flash[:alert] = "Failed to create category, reason: #{@category.errors.full_messages}"
    end
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    unless @category.update(category_params)
      flash[:alert] = "Failed to update category, reason: #{@category.errors.full_messages}"
    end
  end

  def destroy
    @category = Category.find(params[:id])
    @category.delete
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end
end
