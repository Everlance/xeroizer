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

        include BaseModelHttpProxy

        public

        def initialize(application, model_name)
          super
          @model_class ||= Xeroizer::Record::Files.const_get(model_name.to_sym)
        end

        def all(options = {})
          raise MethodNotAllowed.new(self, :all) unless self.class.permissions[:read]
          response = http_get(parse_params(options))
          response = JSON.parse(response)
          if response.is_a?(Array)
            response.map do |item|
              model_class.build(item, self)
            end
          else
            model_class.build(response, self)
          end
        end

      end
    end
  end
end
