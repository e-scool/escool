class AddBodyToMaterials < ActiveRecord::Migration
  def change
    add_column :materials, :body, :text
  end
end
