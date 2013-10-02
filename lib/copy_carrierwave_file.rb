require "copy_carrierwave_file/version"
require "copy_carrierwave_file/copy_file_service"

module CopyCarrierwaveFile
  def copy_carrierwave_file(original_resource, destination_resource)
    CopyCarrierwaveFile::CopyFileService.new(original_resource, destination_resource).set_file
  end
end
