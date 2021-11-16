class AddDefaultToOtpType < ActiveRecord::Migration[6.1]
  def change
    change_column_default :users, :type_otp, 2
  end
end
