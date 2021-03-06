class User < ApplicationRecord
  validates :email, presence: true, email: true
  validates :uid, presence: true
  validates :provider, presence: true
  has_many :tokens
  has_many :my_polls

  def self.from_omniauth(data)
    # {provider: 'facebook'\\'google', uid: '12345', info: {email: 'uriel', name: 'Cristian'}}
    #Recibir hash de datos

    #data[:info][:email]
    User.where(provider: data[:provider], uid: data[:uid]).first_or_create do |user|
      user.email = data[:info][:email]
    end
    #User.create(provider: data[:provider], uid: data[:uid], email: data[:info][:email])

  end
end
# uid y provider generan una llave compuesta
# ejemplo
#uid 123
#provider: facebook
# uid 123
#provider: google la combinacion de estos dos es lo que forma la llave
