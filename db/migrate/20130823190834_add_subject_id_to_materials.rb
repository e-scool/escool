class AddSubjectIdToMaterials < ActiveRecord::Migration
  def change
    add_column :materials, :subject_id, :integer
  end
end
