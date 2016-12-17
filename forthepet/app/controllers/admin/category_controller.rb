class Admin::CategoryController < Admin::AdminController
  add_crumb 'Categories', '/admin/category'

  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
    add_crumb 'New Category'
  end

  def edit
    @category = Category.find(params[:id])
    add_crumb 'Edit Category'
  end

  def create
    category = Category.new(category_params)

    if category.save
      flash[:success] = "#{category.name} successfully saved"
      redirect_to admin_category_index_path
    else
      flash[:danger] = 'Error Saving Category'
      redirect_to new_admin_category_path
    end
  end

  def update
    @category = Category.find(params[:id])
    old_name = @category.name

    if @category.update(category_params)
      flash[:success] = "Category '#{old_name}' successfully updated to '#{@category.name}'"
      redirect_to admin_category_index_path
    else
      flash[:danger] = 'Error updating category'
      render :edit
    end
  end

  def destroy
    category = Category.friendly.find(params[:id])
    category.destroy
    redirect_to admin_category_index_path
  end

  private

  def category_params
    params.require(:category).permit(:name, :parent_id, :slug, :picture,
      :picture_cache, :remove_picture)
  end
end
