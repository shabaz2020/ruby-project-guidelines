#create Reviews Table
class CreateReviewsTable < ActiveRecord::Migration[6.2]
  def change
    create_table :reviews do |r|
      r.integer :rating
    end 
  end
end
