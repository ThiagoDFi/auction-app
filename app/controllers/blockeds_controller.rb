class BlockedsController < ApplicationController

  def index
    @block = Blocked.new
    @blockeds = Blocked.all
    @cpf = params["query"]
    @registry_code = User.where('registry_code = ?', "#{@cpf}")
  end

  def create
    @registry_code = params[:registry_code]
    @blocked = Blocked.new(registry_code: @registry_code)
    if @blocked.save
      redirect_to blockeds_path, notice: "CPF bloqueado com sucesso!"
    else
      flash[:alert] = "Não foi possivel bloquear o CPF"
      render "index"
    end
  end

  def destroy
    @blocked = Blocked.find(params[:id])
    @blocked.destroy
    redirect_to blockeds_path, notice: "O CPF foi desbloqueado com sucesso."
  end
end