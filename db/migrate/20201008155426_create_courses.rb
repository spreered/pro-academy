class CreateCourses < ActiveRecord::Migration[5.2]
  def change
    create_table :courses do |t|
      t.text :title
      t.integer :status, default: 0, null: false
      t.text :slug, default: "", null: false
      t.integer :duration, default: 31, null: false
      t.references :category, foreign_key: true

      t.timestamps
    end
  end
end
