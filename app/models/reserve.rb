class Reserve < ApplicationRecord
  belongs_to :customer
  belongs_to :address
end
