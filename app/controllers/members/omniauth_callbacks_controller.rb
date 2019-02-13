# frozen_string_literal: true

class Members::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  # You should configure your model like this:
  # devise :omniauthable, omniauth_providers: [:twitter]

  # You should also create an action method in this controller like this:
  # def twitter
  # end
  
  def github
    @member = Member.from_omniauth(request.env["omniauth.auth"])

    if @member.persisted?
      sign_in_and_redirect @member, event: :authentication #this will throw if @member is not activated
      set_flash_message(:notice, :success, kind: "Github") if is_navigational_format?
    else
      session["devise.github_data"] = request.env["omniauth.auth"]
      redirect_to new_member_registration_url
    end
  end

  # def facebook
  #   # You need to implement the method below in your model (e.g. app/models/member.rb)
  #   @member = Member.from_omniauth(request.env["omniauth.auth"])

  #   if @member.persisted?
  #     sign_in_and_redirect @member, event: :authentication #this will throw if @member is not activated
  #     set_flash_message(:notice, :success, kind: "Facebook") if is_navigational_format?
  #   else
  #     session["devise.facebook_data"] = request.env["omniauth.auth"]
  #     redirect_to new_member_registration_url
  #   end
  # end

  def failure
    redirect_to root_path
  end

  # More info at:
  # https://github.com/plataformatec/devise#omniauth

  # GET|POST /resource/auth/twitter
  # def passthru
  #   super
  # end

  # GET|POST /members/auth/twitter/callback
  # def failure
  #   super
  # end

  # protected

  # The path used when OmniAuth fails
  # def after_omniauth_failure_path_for(scope)
  #   super(scope)
  # end
end
