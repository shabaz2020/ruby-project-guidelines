#create Generes table
class CreateGenresTable < ActiveRecord::Migration[6.2]
  def change
    create_table :genres do |r|
      r.string :name
    end
  end
end
