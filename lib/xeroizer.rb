require 'rubygems'
require 'date'
require 'forwardable'
require "active_support/inflector"
# require "active_support/core_ext"
require 'oauth'
require 'oauth/signature/rsa/sha1'
require 'nokogiri'
require 'builder'
require 'time'
require 'bigdecimal'
require 'cgi'

$: << File.expand_path(File.dirname(__FILE__)) 

require 'big_decimal_to_s'
require 'nokogiri_utils'
require 'class_level_inheritable_attributes'
require 'xeroizer/oauth'
require 'xeroizer/http_encoding_helper'
require 'xeroizer/http'
require 'xeroizer/exceptions'

require 'xeroizer/record/base_model'
require 'xeroizer/record/base'

# Include models
require 'xeroizer/models/account'
require 'xeroizer/models/address'
require 'xeroizer/models/branding_theme'
require 'xeroizer/models/contact'
require 'xeroizer/models/credit_note'
require 'xeroizer/models/currency'
require 'xeroizer/models/invoice'
require 'xeroizer/models/item'
require 'xeroizer/models/item_purchase_sale_details'
require 'xeroizer/models/journal'
require 'xeroizer/models/journal_line'
require 'xeroizer/models/line_item'
require 'xeroizer/models/manual_journal'
require 'xeroizer/models/manual_journal_line'
require 'xeroizer/models/option'
require 'xeroizer/models/organisation'
require 'xeroizer/models/payment'
require 'xeroizer/models/phone'
require 'xeroizer/models/tax_rate'
require 'xeroizer/models/tracking_category'
require 'xeroizer/models/tracking_category_child'

require 'xeroizer/report/factory'

require 'xeroizer/response'

require 'xeroizer/generic_application'
require 'xeroizer/public_application'
require 'xeroizer/private_application'
require 'xeroizer/partner_application'
