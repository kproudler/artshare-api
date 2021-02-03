class AddIndexToArtworks < ActiveRecord::Migration[6.0]
  def change
  end
  add_index :artworks, :artist_id
  add_index :artworks, :image_url, unique: true
  add_index :artworks, [:title, :artist_id], unique: true
end
