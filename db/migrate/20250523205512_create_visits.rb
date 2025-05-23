class CreateVisits < ActiveRecord::Migration[8.0]
  def change
    create_table :visits do |t|
      t.references :short_url, null: false, foreign_key: true
      t.string :ip_address
      t.text :user_agent
      t.string :referrer
      t.string :country

      t.timestamps
    end
  end
end
