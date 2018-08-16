module Xeroizer
  module Record
    module Files
      class FileModel < FileBaseModel
        set_permissions :read, :write
      end

      class File < FileBase
        string :mime_type
        integer :size
        datetime_utc :created_date_utc
        datetime_utc :updated_date_utc

        belongs_to :folder
      end
    end
  end
end
