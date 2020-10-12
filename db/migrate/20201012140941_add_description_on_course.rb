class AddDescriptionOnCourse < ActiveRecord::Migration[5.2]
  def change
    add_column :courses, :description, :text, default: ''
  end
end
