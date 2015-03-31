#encoding: utf-8
namespace :model do
  task :db_structure, [:klass] => :environment do |t, args|

    klass = Class.const_get(args[:klass])
    unless klass.table_exists?
      p "Db table is not exists. Please run migrate first." 
      return 
    end

    out_put = ->(array, table) do 
      array.each_with_index do |e, i|
        if e.is_a?(Hash)
          if i == 0
            table << ("# %-20s%2s" % [e[:name], ""])
          else
            table << ("%-20s%2s" % [e[:name], ""])
          end
        else
          if i ==0
            table << ("# %-13s%2s" % [(e.nil? ? "nil" : e), ""])
          else
            table << ("%-13s%2s" % [(e.nil? ? "nil" : e), ""])
          end
        end
      end
      table << "\n"
    end
 
    table = []
    out_put.call [{name: "name"}, "type", "sql_type", "null", "default", "limit", "primary"], table
    table << ("# " + "-" * 105 + "\n")
    klass.columns.each do |c|
      out_put.call [{name: c.name}, c.type, c.sql_type, c.null, c.default, c.limit, c.primary], table
    end

    model_file =  File.expand_path klass.to_s.underscore + ".rb", Rails.root.to_s + "/app/models/"

    result = nil
    if File.exists? model_file
      p "output db structure into #{model_file}."
      File.open(model_file, "a+") do |f|
        content = f.readlines
        tag = 0
        content.each_with_index do |s, i|
          if s =~ /DB_BEGIN/
            tag = i + 1
          end
        end
        `> #{model_file}`
        
        content.insert(tag, table)
        content.flatten!
        content.each do |s|
          f.write s
        end

      end

    else
      p "file does not exist"

    end
    
  end
end
