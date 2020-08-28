[![Build Status](https://travis-ci.org/equivalent/copy_carrierwave_file.svg?branch=master)](https://travis-ci.org/equivalent/copy_carrierwave_file)
[![Code Climate](https://codeclimate.com/github/equivalent/copy_carrierwave_file/badges/gpa.svg)](https://codeclimate.com/github/equivalent/copy_carrierwave_file)
[![Coverage
Status](https://coveralls.io/repos/equivalent/copy_carrierwave_file/badge.png)](https://coveralls.io/r/equivalent/copy_carrierwave_file)
![Gittens](http://gittens.r15.railsrumble.com//badge/equivalent/copy_carrierwave_file)
[![Open Thanks](https://thawing-falls-79026.herokuapp.com/images/thanks-1.svg)](https://thawing-falls-79026.herokuapp.com/r/zrhkfsxi)

# CopyCarrierwaveFile


Simple gem for copying [CarrierWave](https://github.com/carrierwaveuploader/carrierwave) files between resources.
It's solving issues with local and remote storage discussed
[here](http://stackoverflow.com/questions/9921085/whats-the-proper-way-to-copy-a-carrierwave-file-from-one-record-to-another)


## Installation

Add this line to your application's Gemfile:

    gem 'copy_carrierwave_file'

And then execute:

    $ bundle


## Usage

You can use service class directly: 

    original_resource = User.last
    new_resource      = User.new

    CopyCarrierwaveFile::CopyFileService.new(original_resource, new_resource, :avatar).set_file
      # :avatar represents mount point (field)
   
    new_resource.save

or you can include `CopyCarrierwaveFile` module and call `copy_carrierwave_file` :


    class Document
      include CopyCarrierwaveFile  
      mount_uploader :content_file, MyUploader

      def duplicate_file(original)
        copy_carrierwave_file(original, self, :content_file)
        self.save!
      end
    end

    document = Document.new
    document.duplicate_file(Document.last) 

Functionality is the same

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
