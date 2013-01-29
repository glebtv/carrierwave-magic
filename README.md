# CarrierWave::Magic

This allows to set file type with ruby-filemagic instead of an extension

It also sets correct file extension with mime-types gem.

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
