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

      end

      class FileBase < Xeroizer::Record::Base
        class_inheritable_attributes :fields, :possible_primary_keys, :primary_key_name, :summary_only, :validators

        string :name

        public

        def new_model_class(model_name)
          Xeroizer::Record::Files.const_get("#{model_name}Model".to_sym).new(parent.try(:application), model_name.to_s)
        end
      end
    end
  end
end
