# Namespace for legacy records.
module Legacy
end

# Extend ActiveRecord for the legacy database.
module LegacyRecord
  class Base < ActiveRecord::Base
  end
end