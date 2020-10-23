#create BooksTable
class CreateBooksTable < ActiveRecord::Migration[6.2]
  def change
    create_table :books do |r|
      r.string :title
      r.integer :genre_id
      r.integer :author_id
      r.integer :published_date
    end 
  end
end
