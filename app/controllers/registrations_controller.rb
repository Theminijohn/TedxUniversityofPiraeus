class RegistrationsController < Devise::RegistrationsController

  def create
    unless Whitelist.exists?(:email => params[:user][:email])
      redirect_to :back, notice: "We are sorry, this Email is not in our Speakers or Sponsors List"
    else
      super
    end
  end

end


