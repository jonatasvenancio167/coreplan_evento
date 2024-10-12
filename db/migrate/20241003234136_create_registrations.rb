class CreateRegistrations < ActiveRecord::Migration[7.0]
  def change
    create_table :registrations do |t|
      t.string :participant_name
      t.string :participant_email
      t.references :event, null: false, foreign_key: true

      t.timestamps
    end
  end
end
