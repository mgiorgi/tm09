class Admin::UsersController < Admin::BaseController
=begin
  active_scaffold :user do |config|
    config.columns = [ :login, :name, :email, :password, :password_confirmation, :roles ]
    list.columns.exclude :password_confirmation, :password
    columns[:login].label = "Usuario"
    columns[:name].label ="Nombre"
    columns[:email].label = "Email"
    columns[:password].label = "Password"
    columns[:password_confirmation].label = "Confirmación de Password"
  end
=end
end
