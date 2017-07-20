class CreateExperienceImages < ActiveRecord::Migration[5.1]
  def change
    create_table :experience_images do |t|
      t.string :image_file_name
      t.string :image_content_type
      t.integer :image_file_size
      t.datetime :image_updated_at
      t.references :experience, foreign_key: true
    end
  end
end
