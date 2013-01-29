# CarrierWave::Magic

This allows to set file type with ruby-filemagic instead of an extension

To set correct file extension on resulting files:
1) Add 'mime-types' gem I reccomend using 'mime_types' 1.20 from git:

    gem 'mime-types', github: 'halostatue/mime-types'

2) Add this to your uploader (or any other way)

  def filename
    if original_filename.present?
      ext = MIME::Types[file.content_type].nil? ? file.extension : MIME::Types[file.content_type].first.extensions.first
      if version_name != :jpg
        "#{secure_token(10)}.#{ext}"
      else
        "#{secure_token(10)}.jpg"
      end
    end
  end

  protected
  def secure_token(length=16)
    var = :"@#{mounted_as}_secure_token"
    model.instance_variable_get(var) or model.instance_variable_set(var, SecureRandom.hex(length/2))
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
