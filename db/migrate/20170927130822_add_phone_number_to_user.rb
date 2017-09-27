class AddPhoneNumberToUser < ActiveRecord::Migration[5.0]
  def change
  	add_column :users, :phone_number, :string
  	add_column  :users,:verified, :boolean, default: false
  	add_column  :users, :pin,:string

  end
end
