class CreateJobStatistics < ActiveRecord::Migration
  def change
    create_table :job_statistics do |t|
      t.string :position
      t.integer :count
      t.string :type

      t.timestamps
    end
  end
end
