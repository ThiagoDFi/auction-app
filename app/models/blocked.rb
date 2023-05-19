class Blocked < ApplicationRecord

  validates :registry_code, presence: true
  validate :check_cpf
  private

  def check_cpf
    unless self.registry_code.present? && cpf_valido?(self.registry_code)
      self.errors.add(:registry_code, 'Inválido')
    end
  end

  def cpf_valido?(cpf)

    return false unless cpf.length == 11

    sum = 0
    9.times do |i|
      sum += cpf[i].to_i * (10 - i)
    end
    rest = sum % 11
    digit1 = rest < 2 ? 0 : 11 - rest

    sum = 0
    10.times do |i|
      sum += cpf[i].to_i * (11 - i)
    end
    rest = sum % 11
    digit2 = rest < 2 ? 0 : 11 - rest

    cpf[-2..].to_i == (digit1 * 10 + digit2)
  end

end
