module Xeroizer
  module Record
    module Files
      class FolderModel < BaseModel
        set_permissions :read, :write
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
