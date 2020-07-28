class AddAllowTfaForUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :admin_allow_tfa, :boolean
  end
end
