module Users
  class RegistrationsController < Devise::RegistrationsController
    def one_click
      symbols = (('0'..'9').to_a + ('A'..'Z').to_a)
      password = (0...8).map { symbols.to_a[rand(symbols.length)] }.join
      opts = {
          email: params[:email],
          password: password,
          password_confirmation: password
      }
      build_resource(opts)

      if resource.save
        UserMailer.one_click_email(resource, password).deliver
        set_flash_message :notice, :signed_up if is_flashing_format?
        sign_up(resource_name, resource)
      else
        flash[:notice] = 'Account with this email already exists'
      end
      redirect_to request.referer
    end
  end
end