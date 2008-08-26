class CreatePermissions < ActiveRecord::Migration
  def self.up
    create_table :permissions do |t|
        t.integer :role_id, :user_id, :null => false
        t.integer :updated_by
      t.timestamps
    end
  # Make sure the role migration file was generated first
  Role.create(:name => 'administrator')
  # Then, add default admin user
  # Be sure change the password later or in this migration file
  user = User.new
  user.login = "admin"
  user.email = "max.lutterbeck@googlemail.com"
  user.password = "19cheetahz85"
  user.password_confirmation = "19cheetahz85"
  user.save(false)
  user.send(:activate!)

  role = Role.find_by_name('administrator')
  user = User.find_by_login('admin')

  permission = Permission.new
  permission.role = role
  permission.user = user
  permission.save(false)
  end

  def self.down
  drop_table :permissions
  Role.find_by_name('administrator').destroy
  User.find_by_login('admin').destroy
  end
  end