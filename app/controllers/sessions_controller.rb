class SessionsController
  respond_to :json

  def new

  end

  def create
    #Find user by his email
    user = User.find_by_email(params[:email])
    #try to authenticate the user
    if !user.nil? and user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to admin_url
    else
      redirect_to login_url, alert: "Invalid email/password"
    end

  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: "Logged out"
  end

  def failure

  end

  def show_current_user


  end

end