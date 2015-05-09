class UsersController < ApplicationController
  before_filter :authenticate_user!
  #before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :set_user, only: [:show, :destroy]

  # GET /users
  # GET /users.json
  def index
    #@users = User.all
    # pagination!
    @users = User.all.paginate(:page => params[:page], :per_page => 10)
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])
    @artist = Artist.find_by_id(@user.artist_id)
  end

  # GET /users/new
  def new
    redirect_to new_user_registration_path, :status => 301
    #@user = User.new
  end

  # GET /users/1/edit
  def edit
    redirect_to edit_user_registration_path, :status => 301
    #@user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    @user = User.find(params[:id])
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:username,:email)
      #params[:user].require(:username, :email)
    end
end