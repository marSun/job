# == Schema Information
#
# Table name: job_links
#
#  id       :integer          not null, primary key
#  url      :string(255)
#  type     :string(255)
#  position :string(255)
#  sign     :integer          default(0)
#

class JobLink < ActiveRecord::Base
  #
  #column           type                           description
  #id               integer                        唯一标识
  #url              string                         职位的url
  #type             string                         职位来源类型，rails继承使用
  #sign             integer                        标志链接是否抓取过, 0：未抓取  1：已抓取
  #position         string                         职位名称
  #--------------------------------------------------------------------------------------------------
  attr_accessible :id, :url, :type, :sign, :position


end
