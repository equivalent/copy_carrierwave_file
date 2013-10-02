module CopyCarrierwaveFile
  class CopyFileService
    attr_reader :original_document, :document

    def initialize(original_document, document)
      raise "Original document must be Document" unless original_document.is_a? Document
      @original_document = original_document
      @document          = document
    end

    # Set file from original document
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
          raise "Original document has no File"
        end
      else
        raise "Original document has no File"
      end
    end

    def have_file?
      original_document.file.url.present?
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
    #    document.remote_file_url = original_document.file.url
    #
    def set_file_for_remote_storage
       self.document_file = open(original_document.file.url)
    end

    def set_file_for_local_storage
      self.document_file = File.open(original_document.file.file.file)
    end

    def document_file=(file)
      document.send( :"file=", file)
    end

  end
end
