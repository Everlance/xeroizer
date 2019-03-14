module Xeroizer
  module Record
    module Files
      class FolderModel < FileBaseModel
        set_permissions :read, :write

        def create_method
          :http_post
        end
      end

      class Folder < FileBase
        guid :folder_id
        string :name
        integer :file_count
        string :email
        boolean :is_inbox
        has_many :files

        set_primary_key :folder_id

        protected
        def save!
          response = parent.send(parent.create_method, self.to_json, extra_params)
          parse_save_response(response)
        end

        def to_json
          params = {
              'name' => self.name,
              'email' => self.email,
              'is_inbox' => self.is_inbox
          }
          params['folder_id'] = self.folder_id unless self.folder_id.nil?
          JSON.generate(params)
        end

        def parse_save_response(response)
          params = JSON.parse(response)
          self.id = params['Id']
          self.name = params['Name']
          self.is_inbox = params['IsInbox']
          self.file_count = params['FileCount']
        end

        def extra_params(body: nil)
          body ||= self.to_json
          {
              response: :json,
              content_type: 'application/json',
              raw_body: body
          }
        end

      end
    end
  end
end
