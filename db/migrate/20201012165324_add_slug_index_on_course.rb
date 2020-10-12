class AddSlugIndexOnCourse < ActiveRecord::Migration[5.2]
  def change
    add_index :courses, :slug, unique: true
  end
end
