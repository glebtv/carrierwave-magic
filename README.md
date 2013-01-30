# CarrierWave::Magic

This allows to set file type with ruby-filemagic instead of an extension

To set correct file extension on resulting files on disk:

1) Add 'mime-types' gem I reccomend using 'mime_types' 1.20 from git:

    gem 'mime-types', github: 'halostatue/mime-types'

2) Add this to your uploader (or any other way)

    def filename
        if original_filename.present?
            ext = MIME::Types[file.content_type].nil? ? file.extension : MIME::Types[file.content_type].first.extensions.first
            split_extension(original_filename)[0] + '.' + ext
        end
    end


Idea and some of the code from this pull request: https://github.com/jnicklas/carrierwave/pull/949

## Installation

Add this line to your application's Gemfile:

    gem 'carrierwave-magic'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install carrierwave-magic

## Usage

    class ImageUploader < CarrierWave::Uploader::Base
      include CarrierWave::Magic
      process :set_magic_content_type
    end

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
