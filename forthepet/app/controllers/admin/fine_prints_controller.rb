class Admin::FinePrintsController < Admin::AdminController
  add_crumb 'Deals / Fine Prints', '/admin/fine-prints'

  def index
    @fine_prints = FinePrint.all
  end

  def new
    @fine_print = FinePrint.new
    add_crumb 'New Fine Print'
  end

  def edit
    @fine_print = FinePrint.find(params[:id])
    add_crumb 'Edit Fine Print'
  end

  def create
    @fine_print = FinePrint.new(fine_print_params)

    if @fine_print.save
      flash[:success] = 'Fine Print Successfully Created'
    else
      flash[:danger] = 'Error Saving Fine Print'
      render new_admin_fine_prints_path && return
    end
    redirect_to admin_fine_prints_path
  end

  def update
    @fine_print = FinePrint.find(params[:id])
    if @fine_print.update(fine_print_params)
      flash[:success] = 'Fine Print Successfully Updated'
    else
      flash[:danger] = 'Error Updating Fine Print'
      render admin_fine_print_path && return
    end
    redirect_to admin_fine_prints_path
  end

  private

  def fine_print_params
    params.require(:fine_print).permit(:description, :is_default)
  end
end
