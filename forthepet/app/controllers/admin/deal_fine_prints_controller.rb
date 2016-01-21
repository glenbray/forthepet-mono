class Admin::DealFinePrintsController < Admin::AdminController
  add_crumb 'Deals / Deals', '/admin/deals'

  def index
    @deal = Deal.friendly.find(params[:deal_id])
    add_crumb 'Edit Deal', "/admin/deals/#{params[:id]}/edit"
    add_crumb 'Fine Print'
  end

  def create
    deal = Deal.friendly.find(params[:deal_id])
    deal.update_fine_prints(fine_print_ids)
    redirect_to admin_deal_fine_prints_path(deal_id: deal.id)
  end

  private

  def fine_print_ids
    params[:deal][:fine_print_ids].delete_if(&:empty?).map(&:to_i)
  end
end
