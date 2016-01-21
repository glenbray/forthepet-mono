class Admin::ProductImagesController < Admin::AdminController
  add_crumb 'Products', '/admin/products'

  def index
    @product = Product.includes(:photos).find(params[:product_id])
    @photo = Photo.new
    add_crumb 'Edit Product', "/admin/products/#{@product.id}/edit"
    add_crumb 'Images'
  end

  def create
    @photo = Photo.new(image_params)

    @product = Product.find(params[:product_id])
    @photo.product_id = @product.id

    if @photo.save
      flash[:success] = 'Image Saved'
      redirect_to admin_product_images_path @product
    else
      flash[:danger] = 'Image error'
      render :index
    end
  end

  def destroy
    @product = Product.find(params[:product_id])
    if @product.photos.destroy(params[:id])
      flash[:success] = 'Deleted Image'
    else
      flash[:danger] = 'Unable to delete image'
    end
    redirect_to admin_product_images_path @product
  end

  def sort
    params[:photo].each_with_index do |id, index|
      Photo.find(id).update(position: index + 1)
    end
    render nothing: true
  end

  private

  def image_params
    params.require(:photo).permit(:alt_text, :picture)
  end
end
