class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  validates :name, :registry_code, presence: true

  validates :registry_code, uniqueness: true
  validate :check_cpf

  # validates :registry_code, cpf: { message: 'Inválido'}

  before_validation :set_admin


  def set_admin
    if self.email.ends_with?('@leilaodogalpao.com.br')
      self.role = "admin"
    end
  end 
end

def check_cpf
  unless self.registry_code.present? && cpf_valido?(self.registry_code)
    self.errors.add(:registry_code, 'Inválido')
  end
end

def cpf_valido?(cpf)

  return false unless cpf.length == 11

  soma = 0
  9.times do |i|
    soma += cpf[i].to_i * (10 - i)
  end
  resto = soma % 11
  digito1 = resto < 2 ? 0 : 11 - resto

  soma = 0
  10.times do |i|
    soma += cpf[i].to_i * (11 - i)
  end
  resto = soma % 11
  digito2 = resto < 2 ? 0 : 11 - resto

  cpf[-2..].to_i == (digito1 * 10 + digito2)
end
