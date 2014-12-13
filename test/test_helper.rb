require 'bundler/setup'
require 'copy_carrierwave_file'
require 'minitest/autorun'
require 'mocha/setup'
require 'active_record'
require 'carrierwave'
require 'carrierwave/orm/activerecord'
require 'coveralls'
Coveralls.wear! # test coverage

TEST_DIR = File.dirname(__FILE__)
#require './test/support/upload_file_macros.rb'
Dir[TEST_DIR+"/support/**/*.rb"].each{|f| require  f}

class Minitest::Spec
  class << self
    alias :context :describe
  end
end

Fog.mock!

ActiveRecord::Base::establish_connection(adapter: 'sqlite3', database: ':memory:')
ActiveRecord::Base.connection.execute(%{CREATE TABLE documents (id INTEGER PRIMARY KEY, file STRING );})

class LocalFileUploader < CarrierWave::Uploader::Base
  storage :file

  def root
    "#{TEST_DIR}/tmp/" # 
  end
end

class RemoteFileUploader < CarrierWave::Uploader::Base
  storage :fog

  def root
    "#{TEST_DIR}/tmp/" # 
  end
end

class Document < ActiveRecord::Base
end

class LocalDocument < Document
  mount_uploader :file, LocalFileUploader
end

class RemoteDocument < Document
  mount_uploader :file, RemoteFileUploader
end

def remove_uploaded_test_files
  FileUtils.rm_rf(Dir.glob(TEST_DIR+"/tmp/uploads/*"))
end
