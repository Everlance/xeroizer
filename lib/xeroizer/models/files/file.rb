module Xeroizer
  module Record
    module Files
      class FileModel < FileBaseModel
        set_permissions :read, :write

        def create_method
          :http_multipart
        end
      end

      class File < FileBase
        guid :file_id
        string :name
        string :mime_type
        string :body
        datetime_utc :created_date_utc
        datetime_utc :updated_date_utc

        set_primary_key :file_id

        belongs_to :folder

        protected
        def save!
          response = parent.send(parent.create_method, multipart_params)
          parse_save_response(response)
        end

        def to_xml
          params = { 'name' => self.name}
          params['folder_id'] = self.folder.id if self.folder.present?
          params.to_xml
        end

        def multipart_params
          {
              'file' => StringIO.new(self.body),
              'name' => self.name,
              'mime_type' => self.mime_type
          }
        end
      end
    end
  end
end
