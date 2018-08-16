module Xeroizer
  class FilesApplication < GenericApplication
    
    attr_reader :client, :application

    extend Forwardable
    def_delegators :client, :request_token, :authorize_from_request, :authorize_from_access

    FILES_URL = 'https://api.xero.com/files.xro/1.0/'

    # Factory for new Payroll BaseModel instances with the class name `record_type`.
    # Only creates the instance if one doesn't already exist.
    #
    # @param [Symbol] record_type Symbol of the record type (e.g. :Invoice)
    # @return [BaseModel] instance of BaseModel subclass matching `record_type`
    def self.record(record_type)
      define_method record_type do
        var_name = "@#{record_type}_cache".to_sym
        unless instance_variable_defined?(var_name)
          instance_variable_set(var_name, Xeroizer::Record::Files.const_get("#{record_type}Model".to_sym).new(self, record_type.to_s))
        end
        instance_variable_get(var_name)
      end  
    end

    record :File
    record :Folder
    
    def initialize(consumer_key, consumer_secret, options = {})
      options.merge!(xero_url: FILES_URL)
      super
    end

  end
end
