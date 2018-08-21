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
        string :mime_type
        string :body
        datetime_utc :created_date_utc
        datetime_utc :updated_date_utc

        belongs_to :folder

        protected
        def save!
          request = multipart_params
          response = parent.send(parent.create_method, request)
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
              'File-Name' => self.name,
              'Content-Type' => self.mime_type
          }
        end
      end
    end
  end
end
