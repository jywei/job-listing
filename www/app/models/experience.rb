class Experience < ActiveRecord::Base
  belongs_to :country
  belongs_to :industry
  belongs_to :contract_type
  belongs_to :resume
end
