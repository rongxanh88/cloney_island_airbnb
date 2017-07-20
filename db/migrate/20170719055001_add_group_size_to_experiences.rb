class AddGroupSizeToExperiences < ActiveRecord::Migration[5.1]
  def change
    add_column :experiences, :group_size, :integer
    add_column :experiences, :guest_requirements, :text
    add_column :experiences, :cancellation_policy_type, :string
  end
end
