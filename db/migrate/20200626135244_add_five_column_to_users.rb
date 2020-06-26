class AddFiveColumnToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :user_name, :string
    add_column :users, :site_url, :string
    add_column :users, :profile, :string
    add_column :users, :phone_number, :string
    add_column :users, :sex, :string
  end
end
