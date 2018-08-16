module Xeroizer
  module Record
    module Files
      class FolderModel < BaseModel
        set_permissions :read, :write
        set_xero_url 'https://api.xero.com/files.xro/1.0/'
      end

      class Folder < Base
        string :name
        integer :file_count
        string :email
        boolean :is_inbox
        has_many :files
      end
    end
  end
end
