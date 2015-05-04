class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.references :author, index: true
      t.string :title
      t.references :user, index: true
      t.references :user, index: true

      t.timestamps
    end
  end
end
