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
          @model_class ||= Xeroizer::Record::Payroll.const_get(model_name.to_sym)
        end

        def parse_response(response_xml, options = {})
          super(response_xml, {:base_module => Xeroizer::Record::Files}.merge(options))
        end

      end

      class FileBase < Xeroizer::Record::Base
        string :name
      end
    end
  end
end
