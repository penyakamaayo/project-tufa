class AddDeviseTwoFactorToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :consumed_timestep, :integer
  end
end
