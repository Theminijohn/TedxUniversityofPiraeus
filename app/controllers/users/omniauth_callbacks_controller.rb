class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    @user ||=
        User.find_for_facebook_oauth(request.env["omniauth.auth"], current_user)

    if @user.persisted?
      # This will throw if @user is not activated
      sign_in_and_redirect @user, event: :authentication
      if is_navigational_format?
        set_flash_message(:notice, :success, kind: "Facebook")
      end
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end
end