require 'rake'
require 'rake/rdoctask'
require 'spec/rake/spectask'

desc 'Run the specs'
Spec::Rake::SpecTask.new(:spec) do |t|
  t.spec_opts = ['--colour --format progress --loadby mtime --reverse']
  t.spec_files = FileList['spec/**/*_spec.rb']
end

Rake::RDocTask.new do |t|
  t.rdoc_dir = 'doc'
  t.rdoc_files.include('README')
  t.rdoc_files.include('lib/**/*.rb')
  t.options << '--inline-source'
  t.options << '--all'
  t.options << '--line-numbers'
end

begin
  require 'jeweler'
  Jeweler::Tasks.new do |s|
    s.name = "godwit"
    s.summary = "A framework to assist in the migration of data from legacy databases."
    s.email = "mattlins@gmail.com"
    s.homepage = "http://github.com/mlins/godwit"
    s.description = "A framework to assist in the migration of data from legacy databases."
    s.authors = ["Matt Lins"]
    s.files = FileList["[A-Z]*", "{lib,spec,app_generators,godwit_generators}/**/*"]
    s.executables = ['godwit']
    s.add_dependency 'activesupport', '>= 2.1.0'
    s.add_dependency 'mlins-active_migration', '>= 1.0.3'
    s.add_dependency 'rubigen', '>= 1.3.4'
  end
rescue LoadError
  puts "Jeweler not available. Install it with: sudo gem install technicalpickles-jeweler -s http://gems.github.com"
end
