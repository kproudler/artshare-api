class RemoveImageUrLfromArtwork < ActiveRecord::Migration[6.0]
  def change
    remove_column :artworks, :image_url
  end
end
