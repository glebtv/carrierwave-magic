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

    GENERIC_CONTENT_TYPES = %w[      
      application-x/octet-stream

      application/
      application/*
      application/binary
      application/download
      application/download-file
      application/downloadfile
      application/force-download
      application/force_download
      application/oclet-stream
      application/octec-stream
      application/octect-stream
      application/octed-stream
      application/octet
      application/octet-binary
      application/octet-stream
      application/octet_stream
      application/octetstream
      application/octlet-stream
      application/save
      application/save-as
      application/stream
      application/unknown
      application/x-download
      application/x-file-download
      application/x-force-download
      application/x-forcedownload
      application/x-octet-stream
      application/x-octets
      application/x-octetstream
      application/x-unknown
      application/x-unknown-application-octet-stream
      application/x-unknown-content-type
      application/x-unknown-octet-stream

      applicaton/octet-stream

      attachment/octet-stream

      bad/type

      binary/
      binary/*
      binary/octec-stream
      binary/octet-stream
      binary/octet_stream
      binary/octetstream

      content-transfer-encoding/binary

      download/file
      download/test

      file/octet-stream
      file/unknown

      multipart/alternative
      multipart/form-data
      multipart/octet-stream

      octet/stream

      type/unknown

      unknown/
      unknown/application
      unknown/data
      unknown/unknown

      x-application/octet-stream
      x-application/octetstream

      x-unknown/octet-stream
      x-unknown/x-unknown
    ]

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
