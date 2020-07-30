class CreateLogins < ActiveRecord::Migration[6.0]
  def change
    create_table :logins do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.datetime :last_sign_in
      t.inet :ip_address
      t.string :user_agent
      t.string :username
      t.string :email

      t.timestamps
    end
  end
end
