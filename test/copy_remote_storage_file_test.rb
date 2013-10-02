require 'test_helper'

describe CopyCarrierwaveFile::CopyFileService, 'copying remote storage file' do
  include UploadedFileMacros

  let(:document)    { Document.new }
  let(:copy_service){ CopyCarrierwaveFile::CopyFileService.new(original_document, document, :file)}
  let(:original_document){ Document.create }

  after(:all){ remove_uploaded_test_files }

  subject{ FileUtils.identical?(test_file1, document.file.file.file) }


  it 'Document file must be identical to Original document file' do
    mock_file = mock()
    mock_file.expects(:url).at_least_once.returns('http://foo')

    original_document.stubs(:file).returns(mock_file)
    CopyCarrierwaveFile::CopyFileService.any_instance.expects(:open).with('http://foo').returns(test_file1)

    copy_service.set_file
    document.save

    subject.must_equal true
  end
end
