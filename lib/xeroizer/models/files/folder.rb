module Xeroizer
  module Record
    module Files
      class FolderModel < FileBaseModel
        set_permissions :read, :write
      end

      class Folder < FileBase
        string :name
        integer :file_count
        string :email
        boolean :is_inbox
        has_many :files
      end
    end
  end
end
