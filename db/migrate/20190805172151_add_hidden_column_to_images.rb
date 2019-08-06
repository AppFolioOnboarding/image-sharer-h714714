class AddHiddenColumnToImages < ActiveRecord::Migration[5.2]
  def change
    add_column :images, :hidden, :boolean, default: false
  end
end
