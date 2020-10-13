class Admin::CategoriesController < Admin::BaseController 
  before_action :find_category, only: [:edit, :update, :destroy]
  def index
    @categories = Category.all.order(id: :asc)
    @new_category = Category.new
  end

  def create
    @category = Category.new(category_params)
    unless @category.save
      flash.now[:alert] = "Failed to create category, reason: #{@category.errors.full_messages}"
    end
  end

  def update
    unless @category.update(category_params)
      flash.now[:alert] = "Failed to update category, reason: #{@category.errors.full_messages}"
    end
  end

  def destroy
    @category.delete
  end

  private

  def find_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name)
  end
end
