class CreateSongs < ActiveRecord::Migration
  def change
    create_table :songs do |t|
      t.string :play_count
      t.string :title
      t.references :artist
      t.timestamps
    end
  end
end
