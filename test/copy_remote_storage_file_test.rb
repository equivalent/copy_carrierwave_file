require 'test_helper'
  require 'pry'

describe CopyCarrierwaveFile::CopyFileService, 'copying remote storage file' do
  include UploadedFileMacros
  class MockRemoteDocument < Minitest::Mock
    def self.uploaders
      RemoteDocument.uploaders
    end
  end

  let(:document) { MockRemoteDocument.new }
  let(:original_document) { RemoteDocument.create }

  after(:all){ remove_uploaded_test_files }

  it 'Document file must be identical to Original document file' do

    # set any file on original_document so that copy can start
    original_document.remote_file_url = 'http://mock.com/test.jpg'

    # because we do Fog.mock! storage acts now as local, we return some url
    original_document
      .file
      .stubs(:url)
      .returns('http://mock.com/test.jpg')

    document.expect(:remote_file_url=, true, ["http://mock.com/test.jpg"])

    CopyCarrierwaveFile::CopyFileService
      .new(original_document, document, :file)
      .set_file

    document.verify
  end
end
