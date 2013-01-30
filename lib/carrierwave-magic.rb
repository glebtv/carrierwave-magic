require "carrierwave-magic/version"

module CarrierWave
  module Magic
    extend ActiveSupport::Concern

    included do
      begin
        require 'filemagic'
      rescue LoadError => e
        e.message << ' (You may need to install the ruby-filemagic gem)'
        raise e
      end
    end

    module ClassMethods
      def set_magic_content_type(override=false)
        process :set_magic_content_type => override
      end
    end

    GENERIC_CONTENT_TYPES = %w[application/octet-stream binary/octet-stream]

    def generic_content_type?(content_type)
      GENERIC_CONTENT_TYPES.include? content_type
    end

    ##
    # Changes the file content_type using the ruby-filemagic gem
    #
    def set_magic_content_type(override=false)
      if override || file.content_type.blank? || generic_content_type?(file.content_type)
        new_content_type = ::FileMagic.new(::FileMagic::MAGIC_MIME).file( file.path ).split(';').first

        if file.respond_to?(:content_type=)
          file.content_type = new_content_type
        else
          file.instance_variable_set(:@content_type, new_content_type)
        end
      end
    rescue ::Exception => e
      raise CarrierWave::ProcessingError, I18n.translate(:"errors.messages.magic_mime_types_processing_error", e: e, default: 'Failed to process file with FileMagic, Original Error: %{e}')
    end

  end
end
