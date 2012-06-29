class CreateAnimatedGifs < ActiveRecord::Migration
  def change
    create_table :animated_gifs do |t|
      t.string :image
      t.text :shas
      t.timestamps
    end
  end
end
