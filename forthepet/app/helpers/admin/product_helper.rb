module Admin::ProductHelper
  def prod_menu_active(sym, action)
    'active' if sym.to_s == action
  end
end
