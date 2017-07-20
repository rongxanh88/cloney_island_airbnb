class CreateExperiences < ActiveRecord::Migration[5.1]
  def change
    create_table :experiences do |t|
      t.string :title
      t.string :duration
      t.text :tagline
      t.text :what
      t.text :where
      t.text :provisions
      t.text :notes
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
