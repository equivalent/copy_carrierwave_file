# CopyCarrierwaveFile


Simple gem for copying [CarrierWave](https://github.com/carrierwaveuploader/carrierwave) files between resources.
It's solving issues with local and remote storage discussed
[here](http://stackoverflow.com/questions/9921085/whats-the-proper-way-to-copy-a-carrierwave-file-from-one-record-to-another)


## Installation

Add this line to your application's Gemfile:

    gem 'copy_carrierwave_file', github: 'equivalent/copy_carrierwave_file'

And then execute:

    $ bundle


## Usage

    original_resource = Document.last
    new_resource      = Document.new

    CopyCarrierwaveFile::CopyFileService.new(original_resource, new_resource)
    new_resource.save


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
