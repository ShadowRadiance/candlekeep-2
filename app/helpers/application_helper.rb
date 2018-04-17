module ApplicationHelper

  def translate_alert_to_bootstrap(alert_type)
    case alert_type
    when :notice, 'notice'
      'alert-success'
    when :alert, 'alert', :error, 'error'
      'alert-danger'
    else
      "alert-unknown-#{alert_type} border"
    end
  end

end
