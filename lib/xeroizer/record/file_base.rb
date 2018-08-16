module Xeroizer
  module Record
    module Files

      class FileBaseModel < Xeroizer::Record::BaseModel

        class_inheritable_attributes :api_controller_name
        class_inheritable_attributes :permissions
        class_inheritable_attributes :xml_root_name
        class_inheritable_attributes :optional_xml_root_name
        class_inheritable_attributes :xml_node_name

        set_permissions :read, :write

        public

        def model_class
          @model_class ||= Xeroizer::Record::Files.const_get(model_name.to_sym)
        end

        def parse_response(response_xml, options = {})
          super(response_xml, {:base_module => Xeroizer::Record::Files}.merge(options))
        end

        def create(attributes={})
          file_name = attributes.fetch(:name) { 'everlance-upload' }
          body = attributes.fetch(:body)
          record = model_class.new(self)
          record.name = file_name
          record.body = body
          record.create
          record
        end

        def create_method
          :http_post
        end

      end

      class FileBase < Xeroizer::Record::Base
        string :name
        string :body

        public

        def initialize(parent)
          @parent = parent
          @model = new_model_class(self.class.name.demodulize)
          @attributes = {}
        end

        def new_model_class(model_name)
          Xeroizer::Record::Files.const_get("#{model_name}Model".to_sym).new(parent.try(:application), model_name.to_s)
        end

        def create
          request = "--#{FilesApplication::CONTENT_BOUNDARY}\nContent-Disposition: form-data; name=Xero; filename=""#{self.name}.pdf""\nContent-Type: application/pdf\n\n#{self.body}"
          log "[CREATE SENT] (#{__FILE__}:#{__LINE__}) #{request}"
          response = parent.send(parent.create_method, request)
          log "[CREATE RECEIVED] (#{__FILE__}:#{__LINE__}) #{response}"
          parse_save_response(response)
        end
      end
    end
  end
end
