module AdminHelper
  def navigation_elements
    [
      ['home', 'Home', admin_path],
      ['date_range', 'Schedule', root_path],
      ['fingerprint', 'Admins', admin_users_path],
      ['mood', 'Feed', admin_users_path],
    ]
  end
end
