class CreateShows < ActiveRecord::Migration[5.0]
  def change
    create_table :shows do |t|
      t.string :name
      t.string :city
      t.string :state
      t.string :venue
      t.string :local_date
      t.string :local_time
      t.string :genre
    end
  end
end
