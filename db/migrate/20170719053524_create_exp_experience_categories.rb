class CreateExpExperienceCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :exp_experience_categories do |t|
      t.references :experience, foreign_key: true
      t.references :experience_category, foreign_key: true
    end
  end
end
