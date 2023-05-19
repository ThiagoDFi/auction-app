class BlockedsController < ApplicationController

  before_action :check_admin

  def index
    @block = Blocked.new
    @blockeds = Blocked.all
    @cpf = params["query"]
    @registry_code = User.where('registry_code = ?', "#{@cpf}")
  end

  def create
    if params[:blocked].present?
      blocked_params = params.require(:blocked).permit(:registry_code)
      @blocked = Blocked.new(blocked_params)
  
      if @blocked.valid? && @blocked.save
        # Lógica para quando o objeto Blocked for válido e for salvo com sucesso
        redirect_to blockeds_path, notice: 'Blocked criado com sucesso.'
      else
        # Lógica para quando o objeto Blocked for inválido ou não for salvo
        render :index
      end
    else
      # Lógica para lidar com o parâmetro bloqueado ausente ou vazio
      redirect_to blockeds_path
    end
  end

  def destroy
    @blocked = Blocked.find(params[:id])
    @blocked.destroy
    redirect_to blockeds_path, notice: "O CPF foi desbloqueado com sucesso."
  end

  private

  def check_admin
    unless current_user.present? && current_user.admin?
      flash[:alert] = "Apenas usuarios admin tem acesso a essa ação"
      return redirect_to root_path
    end
  end
end