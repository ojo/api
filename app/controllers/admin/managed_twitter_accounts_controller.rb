class Admin::ManagedTwitterAccountsController < ApplicationController
  respond_to :html
  before_action :set_account, only: [:update]

  def create
    ManagedTwitterAccount.create(mta_params)
    redirect_to :back
  end

  def update
    respond_to do |format|
      if @account.update(mta_params)
        format.html { redirect_to admin_socialmedia_path, notice: 'account was successfully updated.' }
      else
        format.html { redirect_to admin_socialmedia_path, notice: @account.errors }
      end
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_account
    @account = ManagedTwitterAccount.find(params[:id])
  end

  def mta_params
    params.require(:managed_twitter_account).permit(:username, :published)
  end
end
