class CustomFailure < Devise::FailureApp
  def recall
    env['PATH_INFO']  = attempted_path
    flash.now[:danger] = i18n_message(:invalid)
    self.response = recall_app(warden_options[:recall]).call(env)
  end

  def redirect
    store_location!
    if flash[:timedout] && flash[:info]
      flash.keep(:timedout)
      flash.keep(:info)
    else
      flash[:info] = i18n_message
    end
    redirect_to redirect_url
  end
end
