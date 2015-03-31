# encoding:utf-8
# == Schema Information
#
# Table name: lagou_jobs
#
#  id            :integer          not null, primary key
#  campany       :string(255)
#  position      :string(255)
#  salary        :string(255)
#  city          :string(255)
#  experience    :string(255)
#  education     :string(255)
#  position_type :string(255)
#  sub_detail    :string(255)
#  pub_time      :string(255)
#  position_key  :string(255)
#  position_url  :string(255)
#  created_at    :datetime
#  updated_at    :datetime
#

# DB_BEGIN
# name                  type           sql_type       null           default        limit          primary        
# ---------------------------------------------------------------------------------------------------------
# id                    integer        int(11)        false          nil            4              true           
# campany               string         varchar(255)   true           nil            255            false          
# position              string         varchar(255)   true           nil            255            false          
# salary                string         varchar(255)   true           nil            255            false          
# city                  string         varchar(255)   true           nil            255            false          
# experience            string         varchar(255)   true           nil            255            false          
# education             string         varchar(255)   true           nil            255            false          
# position_type         string         varchar(255)   true           nil            255            false          
# sub_detail            string         varchar(255)   true           nil            255            false          
# pub_time              string         varchar(255)   true           nil            255            false          
# position_key          string         varchar(255)   true           nil            255            false          
# position_url          string         varchar(255)   true           nil            255            false          
# created_at            datetime       datetime       true           nil            nil            false          
# updated_at            datetime       datetime       true           nil            nil            false          
# DB_END

class LagouJob < ActiveRecord::Base
  attr_accessible :campany, :position, :salary, :city, :experience, :education, :position_type, :sub_detail, :pub_time, :position_key, :position_url

#  def initialize(options)
    #super
    #@campany = options[:campany]
    #@position = options[:position]
    #@salary = options[:salary]
    #@city = options[:city]
    #@experience  = options[:experience]
    #@education = options[:education]
    #@position_type = options[:position_type]
    #@sub_detail = options[:sub_detail]
    #@pub_time = options[:pub_time]
#  end

  def self.add(options)
    create(options)

  end

end
