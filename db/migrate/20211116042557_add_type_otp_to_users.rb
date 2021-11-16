class AddTypeOtpToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :type_otp, :integer
  end
end
