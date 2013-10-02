require 'test_helper'

describe 'CopyCarrierwaveFile', 'copying local storage file' do
  include UploadedFileMacros

  def remove_uploaded_test_files
    FileUtils.rm_rf(Dir.glob(TEST_DIR+"/tmp/uploads/*"))
  end

  let(:document)    { Document.new }
  let(:copy_service){ CopyCarrierwaveFile::CopyFileService.new(original_document, document, :file)}
  let(:original_document) do
    doc = Document.new
    doc.file = test_file1
    doc.save
    doc
  end

  after(:all){ remove_uploaded_test_files }

  subject{ FileUtils.identical?(original_document.file.file.file, document.file.file.file) }

  before do
    copy_service.set_file
    document.save
  end

  it 'Document file must be identical to Original document file' do
    subject.must_equal true
  end
end
