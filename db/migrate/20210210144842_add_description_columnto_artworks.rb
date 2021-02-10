class AddDescriptionColumntoArtworks < ActiveRecord::Migration[6.0]
  def change
    add_column :artworks, :favorite, :boolean, default: false
    add_column :artworks, :description, :text

    add_column :artwork_shares, :favorite, :boolean, default: false
  end
end
