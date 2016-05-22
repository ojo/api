class Admin::ManagedTwitterAccountsController < ApplicationController
  respond_to :html

  def create
    ManagedTwitterAccount.create(mta_params)
    redirect_to :back
  end

  private
  def mta_params
    params.require(:managed_twitter_account).permit(:username)
  end
end
