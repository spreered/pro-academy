class Admin::CategoriesController < Admin::BaseController 
  def index
    @categories = Category.all
    @new_category = Category.new
  end

  def create
    @category = Category.new(category_params)
    unless @category.save
      flash[:alert] = "Failed to create category, reason: #{@category.errors.full_messages}"
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
