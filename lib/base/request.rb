require 'httmultiparty'

module FioAPI
  class Request < FioAPI::Base

    include HTTMultiParty

    # Consant of base part of uri for requesting
    base_uri 'https://www.fio.cz/ib_api/rest/'

    class << self

      # Reader for token
      def token
        @@token
      end

      # Setter for token
      def token= token
        @@token = token
      end
    end

  end
end
