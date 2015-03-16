class CreateLagouJob < ActiveRecord::Migration
  def change
    create_table :lagou_jobs do |t|
      t.string :campany
      t.string :position
      t.string :salary
      t.string :city
      t.string :experience
      t.string :education
      t.string :position_type
      t.string :sub_detail
      t.string :pub_time
      t.string :position_key
      t.string :position_url

      t.timestamps
    end
  end
end
