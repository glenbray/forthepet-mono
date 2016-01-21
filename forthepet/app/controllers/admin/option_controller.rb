class Admin::OptionController < Admin::AdminController
  add_crumb 'Options', '/admin/option'

  def index
    @options = Option.all
  end

  def new
    @option = Option.new
    add_crumb 'New Option'
  end

  def edit
    @option = Option.find(params[:id])
    add_crumb 'Edit Option'
  end

  def create
    option = Option.new(option_params)

    if option.save
      flash[:success] = 'Option saved successfully'
    end

    redirect_to admin_option_index_path
  end

  def update
    option = Option.find(params[:id])

    if option.update(option_params)
      flash[:success] = 'Option updated successfully'
    else
      flash[:danger] = 'Option failed to update'
    end

    redirect_to admin_option_index_path
  end

  private

  def option_params
    params.require(:option).permit(:name, :presentation)
  end
end
