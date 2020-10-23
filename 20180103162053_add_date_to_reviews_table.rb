#create addDateReviewsTab;e
class AddDateToReviewsTable < ActiveRecord::Migration[6.2]
  def change
    add_column :reviews, :reviewed_date, :datetime
    add_column :reviews, :book_id, :integer
    add_reference :reviews, :user, index: true, foreign_key: true
  end
end
