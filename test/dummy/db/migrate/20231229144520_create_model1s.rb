class CreateModel1s < ActiveRecord::Migration[7.1]
  def change
    create_table :model1s do |t|
      t.string :code

      t.timestamps
    end
  end
end
