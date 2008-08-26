class CreateLandingpages < ActiveRecord::Migration
  def self.up
    create_table :landingpages do |t|
      
      t.string :title, :category
      t.text :description

      t.timestamps
    end
  end

  def self.down
    drop_table :landingpages
  end
end
