require 'rails_helper'

RSpec.describe User, type: :model do
  it { should validate_presence_of(:email) }
  it { should_not allow_value("cristian@mayan-tech").for(:email) }
  it { should allow_value("cristian@mayan-tech.com").for(:email) }
  it { should validate_presence_of(:uid) }
  it { should validate_presence_of(:provider) }

  it "deberia crear un usuario si el uid no existe" do
    expect {
      User.from_omniauth({ uid: "12345", provider: "facebook", info: { email: "cristian@mayan-tech.com" }})
    }.to change(User, :count).by(1)
  end
  it "deberia encontrar un usuario si el uid y el provider ya existen" do
    user = FactoryGirl.create(:user)
    expect {
      User.from_omniauth({uid: user.uid, provider: user.provider, info: { email: "cristian@mayan-tech.com" }})
    }.to change(User, :count).by(0)
  end

  it "deberia retornar el usuario encontrado si el uid y provider ya existe" do
    user = FactoryGirl.create(:user)
    expect(
      User.from_omniauth({uid: user.uid, provider: user.provider })
    ).to eq(user)
  end
end
# cuando se pone expect() es porque estamos esperando lo que retorne
# cuando se ponene expect{} es una forma de declarar bloques en ruby, se espera la ejecucion
