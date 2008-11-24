# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{godwit}
  s.version = "1.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Matt Lins"]
  s.date = %q{2008-11-24}
  s.default_executable = %q{godwit}
  s.description = %q{A framework to assist in the migration of data from legacy databases.}
  s.email = %q{mattlins@gmail.com}
  s.executables = ["godwit"]
  s.files = ["CHANGELOG", "MIT-LICENSE", "Rakefile", "README", "VERSION.yml", "lib/godwit", "lib/godwit/active_migration.rb", "lib/godwit/base.rb", "lib/godwit/bootloader.rb", "lib/godwit/buffer.rb", "lib/godwit/callbacks.rb", "lib/godwit/config.rb", "lib/godwit/irb.rb", "lib/godwit/legacy_record.rb", "lib/godwit/version.rb", "lib/godwit.rb", "spec/active_migration_generator_spec.rb", "spec/active_model_generator_spec.rb", "spec/buffer_spec.rb", "spec/callbacks_spec.rb", "spec/config_spec.rb", "spec/godwit_generator_spec.rb", "spec/legacy_model_generator_spec.rb", "spec/spec.opts", "spec/spec_helper.rb", "app_generators/godwit", "app_generators/godwit/godwit_generator.rb", "app_generators/godwit/templates", "app_generators/godwit/templates/config", "app_generators/godwit/templates/config/database.yml", "app_generators/godwit/templates/config/environment.rb", "app_generators/godwit/templates/log", "app_generators/godwit/templates/log/active_migration.log", "app_generators/godwit/templates/log/active_record.log", "app_generators/godwit/templates/Rakefile", "app_generators/godwit/templates/script", "app_generators/godwit/templates/script/console", "app_generators/godwit/templates/script/lib", "app_generators/godwit/templates/script/lib/console.rb", "app_generators/godwit/templates/script/migrate", "godwit_generators/active_migration", "godwit_generators/active_migration/active_migration_generator.rb", "godwit_generators/active_migration/templates", "godwit_generators/active_migration/templates/active_migration.rb", "godwit_generators/active_model", "godwit_generators/active_model/active_model_generator.rb", "godwit_generators/active_model/templates", "godwit_generators/active_model/templates/active_model.rb", "godwit_generators/legacy_model", "godwit_generators/legacy_model/legacy_model_generator.rb", "godwit_generators/legacy_model/templates", "godwit_generators/legacy_model/templates/legacy_model.rb", "bin/godwit"]
  s.homepage = %q{http://github.com/mlins/godwit}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{A framework to assist in the migration of data from legacy databases.}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activesupport>, [">= 2.1.0"])
      s.add_runtime_dependency(%q<mlins-active_migration>, [">= 1.0.4"])
      s.add_runtime_dependency(%q<rubigen>, [">= 1.3.4"])
    else
      s.add_dependency(%q<activesupport>, [">= 2.1.0"])
      s.add_dependency(%q<mlins-active_migration>, [">= 1.0.4"])
      s.add_dependency(%q<rubigen>, [">= 1.3.4"])
    end
  else
    s.add_dependency(%q<activesupport>, [">= 2.1.0"])
    s.add_dependency(%q<mlins-active_migration>, [">= 1.0.4"])
    s.add_dependency(%q<rubigen>, [">= 1.3.4"])
  end
end
