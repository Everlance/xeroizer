module Xeroizer
  module Record
    module Files
      class FileBase < Xeroizer::Record::Base
        class_inheritable_attributes :fields, :possible_primary_keys, :primary_key_name, :summary_only, :validators

        class << self

          def has_many(field_name, options = {})
            super(field_name, {:base_module => Xeroizer::Record::Files}.merge(options))
          end

          def belongs_to(field_name, options = {})
            super(field_name, {:base_module => Xeroizer::Record::Files}.merge(options))
          end

          # Build a record with attributes set to the value of attributes.
          def build(attributes, parent)
            record = new(parent)
            attributes.each do | key, value |
              field_key = record.class.fields.find { |_, params| params[:api_name].to_s == key.to_s }
              attr = field_key.nil? ? key : field_key.last[:internal_name]
              record.send("#{attr}=", value)
            end
            record
          end

        end

        public

        def new_model_class(model_name)
          Xeroizer::Record::Files.const_get("#{model_name}Model".to_sym).new(parent.try(:application), model_name.to_s)
        end
      end
    end
  end
end
