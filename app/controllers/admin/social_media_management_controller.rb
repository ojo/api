class Admin::SocialMediaManagementController < Admin::BaseController 

  respond_to :html

  def index
    @num_tweets = params[:num_tweets] ? params[:num_tweets] : 10
  end

  def instagram_oauth_callback
    callback = admin_socialmedia_instagram_oauth_callback_url
    resp = Instagram.get_access_token(params[:code], redirect_uri: callback)
    client = Instagram.client(access_token: resp.access_token)
    user = client.user

    ManagedInstagramAccount.with_advisory_lock(self.class.name, 0) do
      ManagedInstagramAccount.transaction do
        begin
          a = ManagedInstagramAccount.find(user.id)
        rescue ActiveRecord::RecordNotFound
          a = ManagedInstagramAccount.new
          a.id = user.id
          a.username = user.username
        end
        a.token = resp.access_token
        a.save
      end
    end

    redirect_to admin_socialmedia_path
  end

  def instagram_oauth_connect
    callback = admin_socialmedia_instagram_oauth_callback_url
    redirect_to Instagram.authorize_url(redirect_uri: callback)
  end
end
