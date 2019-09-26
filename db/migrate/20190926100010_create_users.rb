class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :email
      t.string :name
      t.string :github_id
      t.string :image_url
      t.string :access_token

      t.timestamps
    end
  end
end
