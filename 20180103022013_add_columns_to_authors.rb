#create AddColumnsToAuthors Table
class AddColumnsToAuthors < ActiveRecord::Migration[6.2]
  def change
    add_column :authors, :goodreads_id, :string
    add_column :authors, :goodreads_url, :string
  end
end
