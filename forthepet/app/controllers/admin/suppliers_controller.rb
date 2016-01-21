class Admin::SuppliersController < Admin::AdminController
  add_crumb 'Suppliers', '/admin/suppliers'

  def index
    @q = Supplier.search(params[:q])
    @suppliers = @q.result.page params[:page]
    @supplier = Supplier.new
  end

  def create
    if Supplier.create(create_supplier)
      flash[:success] = 'Supplier Saved'
    else
      flash[:danger] = 'Error Saving Supplier'
    end

    redirect_to admin_suppliers_path
  end

  def new
    @supplier = Supplier.new
    add_crumb 'New Supplier'
  end

  def edit
    @supplier = Supplier.find(params[:id])
    add_crumb 'Edit Supplier'
  end

  def update
    supplier = Supplier.find(params[:id])

    if supplier.update(update_supplier)
      flash[:success] = 'Supplier updated.'
    else
      flash[:danger] = 'Error updating supplier.'
    end

    redirect_to admin_suppliers_path
  end

  def destory
  end

  private

  def create_supplier
    params.require(:supplier).permit(:name, :abn, :phone, :mobile, :fax, :email)
  end

  def update_supplier
    params.require(:supplier).permit(:name, :abn, :phone, :mobile, :fax, :email)
  end
end
