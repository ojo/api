class Admin::ManagedInstagramAccountsController < ApplicationController
  before_action :set_managed_instagram_account, only: [:show, :edit, :update, :destroy]

  # GET /managed_instagram_accounts
  # GET /managed_instagram_accounts.json
  def index
    @managed_instagram_accounts = ManagedInstagramAccount.all
  end

  # GET /managed_instagram_accounts/1
  # GET /managed_instagram_accounts/1.json
  def show
  end

  # GET /managed_instagram_accounts/new
  def new
    @managed_instagram_account = ManagedInstagramAccount.new
  end

  # GET /managed_instagram_accounts/1/edit
  def edit
  end

  # POST /managed_instagram_accounts
  # POST /managed_instagram_accounts.json
  def create
    @managed_instagram_account = ManagedInstagramAccount.new(managed_instagram_account_params)

    respond_to do |format|
      if @managed_instagram_account.save
        format.html { redirect_to @managed_instagram_account, notice: 'Managed instagram account was successfully created.' }
        format.json { render :show, status: :created, location: @managed_instagram_account }
      else
        format.html { render :new }
        format.json { render json: @managed_instagram_account.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /managed_instagram_accounts/1
  # PATCH/PUT /managed_instagram_accounts/1.json
  def update
    respond_to do |format|
      if @managed_instagram_account.update(managed_instagram_account_params)
        format.html { redirect_to admin_socialmedia_path, notice: 'Managed instagram account was successfully updated.' }
        format.json { render :show, status: :ok, location: @managed_instagram_account }
      else
        format.html { render :edit }
        format.json { render json: @managed_instagram_account.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /managed_instagram_accounts/1
  # DELETE /managed_instagram_accounts/1.json
  def destroy
    @managed_instagram_account.destroy
    respond_to do |format|
      format.html { redirect_to managed_instagram_accounts_url, notice: 'Managed instagram account was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_managed_instagram_account
      @managed_instagram_account = ManagedInstagramAccount.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def managed_instagram_account_params
      params.fetch(:managed_instagram_account, {}).permit(:published)
    end
end
