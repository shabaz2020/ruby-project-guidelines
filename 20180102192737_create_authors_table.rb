#create Authors table
class CreateAuthorsTable < ActiveRecord::Migration[6.2]
  def change
    create_table :authors do |r|
      r.string :name 
    end
  end
end
