class CreateExperienceCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :experience_categories do |t|
      t.string :name
    end
  end
end
