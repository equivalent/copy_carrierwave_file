module CopyCarrierwaveFile
  class CopyFileService
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

    # Set file from original resource
    #
    # Founded originally at http://bit.ly/ROGtPR
    #
    def set_file
      if have_file?
        begin
          set_file_for_remote_storage
        rescue Errno::ENOENT
          set_file_for_local_storage
        rescue NoMethodError
          raise "Original resource has no File"
        end
      else
        raise "Original resource has no File"
      end
    end

    def have_file?
      original_resource.file.url.present?
    end

    # Set file when you use remote storage for your files (like S3)
    #
    # will try to fetch full remote path of a file with `open-uri`
    #
    # If you use local storage, `doc.file.url` will return relative path, therefor
    # this will fail with Errno::ENOENT
    #
    # If you have issues with code try alternative code:
    #
    #    resource.remote_file_url = original_resource.file.url
    #
    def set_file_for_remote_storage
      set_resource_mounter_file open(original_resource_mounter.url)
    end

    def set_file_for_local_storage
      set_resource_mounter_file File.open(original_resource_mounter.file.file)
    end

    def original_resource_mounter
      original_resource.send(mount_point)
    end

    def set_resource_mounter_file(file)
      resource.send( :"#{mount_point.to_s}=", file)
    end

  end
end
