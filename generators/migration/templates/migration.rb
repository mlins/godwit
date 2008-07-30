class <%= name.camelize %> < ActiveMigration::Base
  
  set_active_model '<%= active_model %>'
  
  set_legacy_model '<%= legacy_model %>'
  
  map              []
  
end