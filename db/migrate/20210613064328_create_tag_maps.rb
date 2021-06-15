class CreateTagMaps < ActiveRecord::Migration[5.2]
  def change
    create_table :tag_maps do |t|
      t.references :review, foreign_key: true
      t.references :tag, foreign_key: true

      t.timestamps
    end
  end
end
