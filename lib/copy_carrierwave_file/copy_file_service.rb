module CopyCarrierwaveFile
  class CopyFileService
    NoFileForOriginalResource = Class.new(StandardError)
    UnknowStorage             = Class.new(StandardError)

    attr_reader :original_resource, :resource, :mount_point

    def initialize(original_resource, resource, mount_point)
      @mount_point       = mount_point.to_sym

      raise "#{original_resource} is not a resource with uploader" unless original_resource.class.respond_to? :uploaders
      raise "#{original_resource} doesn't have mount point #{mount_point}" unless original_resource.class.uploaders[@mount_point]

      raise "#{resource} is not a resource with uploader" unless resource.class.respond_to? :uploaders
      raise "#{resource} doesn't have mount point #{mount_point}" unless resource.class.uploaders[@mount_point]

      @original_resource = original_resource
      @resource          = resource
    end

    # #set_file
    #
    # sets file for given storage type
    #
    # reason why case is comparing String and not actual storage class
    # is that user may or may not add gem "fog" => this class may not be
    # loaded
    #
    def set_file
      if have_file?
        case original_resource_mounter.send(:storage).class.name
        when 'CarrierWave::Storage::File'
          set_file_for_local_storage
        when 'CarrierWave::Storage::Fog'
          set_file_for_remote_storage
        when 'CarrierWave::Storage::aws'
          set_file_for_remote_storage
        else
          raise UnknowStorage
        end
      else
        raise NoFileForOriginalResource
      end
    end

    def have_file?
      original_resource_mounter.file.present?
    end

    def set_file_for_remote_storage
      resource.send(:"remote_#{mount_point.to_s}_url=", original_resource_mounter.url)
    end

    def set_file_for_local_storage
      resource.send(:"#{mount_point.to_s}=", File.open(original_resource_mounter.file.file))
    end

    def original_resource_mounter
      original_resource.send(mount_point)
    end

  end
end
