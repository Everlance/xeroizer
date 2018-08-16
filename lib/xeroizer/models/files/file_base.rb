module Xeroizer
  module Record
    module Files

      class FileBaseModel < BaseModel
        set_permissions :read, :write
      end

      class FileBase < Base
        string :name
      end
    end
  end
end
