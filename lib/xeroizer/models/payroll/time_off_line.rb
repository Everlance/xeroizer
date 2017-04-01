module Xeroizer
  module Record
    module Payroll

      class TimeoffLineModel < PayrollBaseModel

      end

      class TimeoffLine < PayrollBase

        guid :time_off_type_id, :api_name => 'TimeOffTypeID'
        decimal :hours
        decimal :balance

        validates_presence_of :leave_type_id, :unless => :new_record?
      end

    end
  end
end