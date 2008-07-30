Godwit::Config.use do |config|

  # Change this if you would like to store key maps somewhere else.
  #
  #config[:key_mapper_path] = File.join(Godwit::Config[:godwit_root], 'tmp')

  # This will load a Rails instance to use for your active dataset.
  #
  #config[:rails_root] = '/my/new/rails/app'

end

# This is usually just a dep warning, but we want it to fail.
Object.send :undef_method, :id