class CreateAppointments < ActiveRecord::Migration[5.2]
  def change
    create_table :appointments do |t|
      t.integer :start_time
      t.integer :end_time
      t.string :name
      t.integer :schedule_id
      t.timestamps
    end
  end
end
