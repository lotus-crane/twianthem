class CreateNowplayData < ActiveRecord::Migration[5.2]
  def change
    create_table :nowplay_data do |t|
      t.string :song
      t.string :artist
      t.string :user_id
      t.timestamps
    end
  end
end
