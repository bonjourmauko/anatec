class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :title
      t.string :author
      t.references :owner, index: true
      t.references :borrower, index: true

      t.timestamps
    end
  end
end
