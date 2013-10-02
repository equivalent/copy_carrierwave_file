require 'carrierwave/test/matchers'

# UploadedFileMacros
#
# set of file upload helpers for CarrierWave
#
# If you want to lern more read my scrap on CarrierWave 
# https://github.com/equivalent/scrapbook2/blob/master/carrierwave.md
#
module UploadedFileMacros

  def uploaded_test_file1
    ActionDispatch::Http::UploadedFile.new({
      :filename => 'test_file1',
      :content_type => 'txt',
      :tempfile => test_file1
    })
  end

  # For comparing the upladed file match
  #
  #    document.file.file.file.should be_identical_to file_for_upload
  #
  def test_file1
    File.new("#{TEST_DIR}/fixtures/uploads/test_file1.txt")
  end

  def test_file2
    File.new("#{TEST_DIR}/fixtures/uploads/test_file2.txt")
  end

end
