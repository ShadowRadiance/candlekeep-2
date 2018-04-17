class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?


  def require_admin!
    unless current_user.is_admin?
      redirect_back(
        fallback_location: root_path,
        alert: 'Unauthorized')
    end
  end


  protected

  def configure_permitted_parameters
    # Permit the `subscribe_newsletter` parameter along with the other
    # sign up parameters.
    devise_parameter_sanitizer.permit(:sign_up, keys: [:time_zone])
    devise_parameter_sanitizer.permit(:account_update, keys: [:time_zone])
  end

end
