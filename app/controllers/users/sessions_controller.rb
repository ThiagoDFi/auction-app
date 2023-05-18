class Users::SessionsController < Devise::SessionsController
  def create
    resource = warden.authenticate!(auth_options)
    cpf = resource.registry_code
    blocked = Blocked.find_by(registry_code: cpf)

    if blocked
      flash[:alert] = 'Sua conta está suspensa.'
      redirect_to root_path and return
    end
    super
  end
end