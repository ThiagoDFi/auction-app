class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  before_validation :set_admin

  def set_admin
    if self.email.ends_with?('@leilaodogalpao.com.br')
      self.role = "admin"
    end
  end
end
