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

  # I'm not 100% sure I want these in the Helper or the Controller
  # I think it's a helper, because only the Views care about the UserNavigation

  def generate_user_nav
    if user_signed_in?
      member_nav(current_user)
    else
      guest_nav
    end
  end

  private

  def member_nav(user)
    {
      time: "Local: #{Time.current.in_time_zone(user.time_zone).to_s(:long)}",
      dropdown: {
        type: 'Member',
        name: current_user.email,
        links: [
          link_to('Edit profile', edit_user_registration_path, class: 'dropdown-item'),
          link_to('Logout', destroy_user_session_path, method: :delete, class: 'dropdown-item')
        ]
      }
    }
  end

  def guest_nav
    {
      time: "Server: #{Time.current.to_s(:long)}",
      dropdown: {
        type: 'Guest',
        name: 'Guest',
        links: [
          link_to('Sign up', new_user_registration_path, class: 'dropdown-item'),
          link_to('Login', new_user_session_path, class: 'dropdown-item')
        ]
      }
    }
  end

  def copy_location(copy, user)
    return copy.location unless user&.is_admin?
    return copy.location unless copy.current_borrower

    copy.current_borrower.email

    # link_to(
    #   copy.current_borrower.email,
    #   user_checkouts_path(copy.current_borrower)
    # ).html_safe
  end
end
