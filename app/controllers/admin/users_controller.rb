class Admin::UsersController < Admin::ApplicationController
  def index
    @filter = {query: params[:query]}

    @users = if @filter[:query].present?
      @sort = nil
      User.basic_search(@filter[:query]).page(params[:p]).per(25)
    else
      @sort = params[:sort].try(:downcase) || 'date'
      case @sort
      when 'name'
        User.order('surname asc, given_name asc, email_address asc').page(params[:p]).per(25)
      when 'date'
        User.order('created_at desc').page(params[:p]).per(25)
      else
        raise "Unsupported sort option: #{ @sort }"
      end
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(create_params)
    @user.set_password_at = Time.zone.now
    if @user.save
      redirect_to [:admin, @user]
    else
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(update_params)
      @user.remove_sensitive_information_from_stripe!
      @user.subscription.remove_sensitive_information_from_stripe!
      redirect_to [:admin, @user]
    else
      render :edit
    end
  end

  def reset_password
    @user = User.find(params[:id])
    @user.deliver_reset_password_instructions! if @user
    redirect_to [:admin, @user]
  end

  def impersonate
    @user = User.find(params[:id])
    impersonate_user(@user)
    redirect_to :root
  end

  private

  def create_params
    params.require(:user).permit(:email_address, :given_name, :surname, :password, :role)
  end

  def update_params
    params.require(:user).permit(:email_address, :given_name, :surname, :role, :address_line_1, :address_line_2, :city, :county, :post_code, :country_code, :hub)
  end
end
