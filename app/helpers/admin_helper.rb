module AdminHelper
  def navigation_elements
    [
      ['home', 'Home', admin_path],
      ['mood', 'Social Media', admin_socialmedia_path],
      ['date_range', 'Schedule', root_path],
      ['fingerprint', 'Admins', admin_users_path],
    ]
  end
end
