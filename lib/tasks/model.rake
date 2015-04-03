#encoding: utf-8
module RakeModelTools
  class Builder
    def initialize(klass)
      @klass = klass
    end

    def build
      titles = build_title(["name", "type", "sql_type", "null", "default", "limit", "primary"])
      contents = build_content(@klass.columns)
      title_line = Line.new(titles)

      data_table = [title_line] + contents
      data_table.collect!(&:out_put)

      m_file = ModelFile.new(@klass, data_table)
      m_file.print_file
    end

    def build_column(items)
      columns = []
      items.each_with_index do |e, i|
        c = (i == 0) ? Column.new(e, 20, true) : Column.new(e)
        columns << c.out_put
      end
      return columns
    end

    def build_content(ar_columns)
      lines = []
      ar_columns.each do |c|
        columns = build_column([c.name, c.type, c.sql_type, c.null, c.default, c.limit, c.primary])
        lines << Line.new(columns)
      end
      return lines
    end

    def build_title(title_items)
      return build_column(title_items)
    end
  end

  class Column
    def initialize(name, length=13, is_title=false)
      @name     = name
      @length   = length
      @is_title = is_title
    end

    def out_put
      "%-#{@length.to_s}s%2s" % [@name, ""]
    end

  end
  
  class Line
    def initialize(columns)
      @columns = columns
    end

    def out_put
      prefix + @columns.join("") + endl
    end

    def self.division
      prefix + "-" * 105 + endl

    end

    private
    def prefix
      "# "
    end
    
    def endl
      "\n" 
    end

  end

  class ModelFile

    def initialize(klass, data_table)
      @klass = klass
      @file  = file_from_convention
      @data_table = data_table
    end

    def print_file
      if File.exists? @file
        p "output db structure into #{@file}."
        File.open(@file, "a+") do |f|
          content = f.readlines
          tag = 0
          content.each_with_index do |s, i|
            if s =~ /DB_BEGIN/
              tag = i + 1
            end
          end
          `> #{@file}`
          
          content.insert(tag, @data_table)
          content.flatten!
          content.each do |s|
            f.write s
          end

        end

      else
        p "file does not exist"

      end
    end

    private
    def file_from_convention
      file = File.expand_path @klass.to_s.underscore + ".rb", Rails.root.to_s + "/app/models/" 
      return file if validate_file(file)
    end

    def validate_file(file)
      str = ""
      File.open(file, "a+") do |f|
        f.each_line do|l|
          if l =~ /class [A-Z][A-Za-z_]* < ActiveRecord::Base.*/
            str = l
            break
          end
        end
      end
      klass = str.split(" ")[1]
      if klass == @klass.to_s
        return true
      else
        raise "class not match!Input class is #{@klass.to_s}, but the class in the file is #{klass}"
      end
    end

  end

end
namespace :model do
  task :db_structure, [:klass] => :environment do |t, args|
    klass = Class.const_get(args[:klass])
    builder = RakeModelTools::Builder.new(klass)
    builder.build
  end
end
