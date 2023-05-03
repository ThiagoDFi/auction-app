class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  validates :name, :registry_code, presence: true

  validates :registry_code, uniqueness: true
  validate :cpf_valid

  before_validation :set_admin

  def set_admin
    if self.email.ends_with?('@leilaodogalpao.com.br')
      self.role = "admin"
    end
  end

  def cpf_valid
  end
end
