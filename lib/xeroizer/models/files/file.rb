module Xeroizer
  module Record
    module Files
      class FileModel < BaseModel
        set_permissions :read, :write
        set_xero_url 'https://api.xero.com/files.xro/1.0/'
      end

      class File < Base
        string :name
        string :mime_type
        integer :size
        datetime_utc :created_date_utc
        datetime_utc :updated_date_utc

        belongs_to :folder
      end
    end
  end
end
