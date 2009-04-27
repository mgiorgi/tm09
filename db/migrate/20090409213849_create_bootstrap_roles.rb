class CreateBootstrapRoles < ActiveRecord::Migration
  def self.up
    Role.create!(:name => 'nivel1')
    Role.create!(:name => 'nivel2')
  end

  def self.down
    Role.delete_all
  end
end
