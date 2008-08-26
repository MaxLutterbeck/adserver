class CreateImageServices < ActiveRecord::Migration
  def self.up
    create_table :image_services do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :image_services
  end
end
