class Admin::OptionValueController < Admin::AdminController
  add_crumb 'Options', '/admin/option'

  def index
    @option_value = OptionValue.new(option_id: params[:option_id])
    @option = Option.find(params[:option_id])
    add_crumb 'Option Values'
  end

  def edit
    @option_value = OptionValue.find(params[:id])
    add_crumb 'Option Values', "/admin/option/#{params[:option_id]}/values"
    add_crumb 'Edit Option Value'
  end

  def create
    option_value = OptionValue.new(option_value_params)

    if option_value.save
      flash[:success] = 'Option value saved'
    else
      flash[:danger] = 'Option value could not save'
    end
    redirect_to admin_option_option_value_index_path
  end

  def update
    option_value = OptionValue.find(params[:id])

    if option_value.update(option_value_params)
      flash[:success] = 'Option value updated'
    else
      flash[:danger] = 'Option value could not update'
    end
    redirect_to admin_option_option_value_index_path
  end

  def sort
    params[:option_value].each_with_index do |id, index|
      OptionValue.find(id).update(position: index + 1)
    end
    render nothing: true
  end

  private

  def option_value_params
    params.require(:option_value).permit(:option_id, :name, :display)
  end
end
