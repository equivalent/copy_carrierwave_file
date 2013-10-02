require 'bundler/setup'
require 'copy_carrierwave_file'
require 'minitest/autorun'
require 'mocha'
require 'active_record'
require 'carrierwave'
require 'carrierwave/orm/activerecord'

TEST_DIR = File.dirname(__FILE__)
#require './test/support/upload_file_macros.rb'
Dir[TEST_DIR+"/support/**/*.rb"].each{|f| require  f}

class Minitest::Spec
  class << self
    alias :context :describe
  end
end

ActiveRecord::Base::establish_connection(adapter: 'sqlite3', database: ':memory:')
ActiveRecord::Base.connection.execute(%{CREATE TABLE documents (id INTEGER PRIMARY KEY, file STRING );})


class FileUploader < CarrierWave::Uploader::Base
  storage :file

  def root
    "#{TEST_DIR}/tmp/" # 
  end
end


class Document < ActiveRecord::Base
  mount_uploader :file, FileUploader
end

def remove_uploaded_test_files
  FileUtils.rm_rf(Dir.glob(TEST_DIR+"/tmp/uploads/*"))
end


