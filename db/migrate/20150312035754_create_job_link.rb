class CreateJobLink < ActiveRecord::Migration
  def change
    create_table :job_links do |t|
      t.string :url
      t.string :type
      t.string :position
      t.integer :sign, default: 0
    end
  end
end
