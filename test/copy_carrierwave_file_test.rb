require 'test_helper'
describe 'CopyCarrierwaveFile', 'included module' do

  before do
    Document.send :include, CopyCarrierwaveFile
  end

  it do
    file_service_object = mock()
    file_service_object.expects(:set_file).at_least_once.returns(true)

    CopyCarrierwaveFile::CopyFileService.expects(:new).with('one', 'two', :file).returns(file_service_object)
    Document.new.copy_carrierwave_file('one','two', :file)
  end
  
end
