Gem::Specification.new do |s|
  s.name             = 'hoster'
  s.version          = '0.1.3'
  s.platform         = Gem::Platform::RUBY
  s.summary          = 'Allows you to easily modify your local hosts file using one simple command'
  s.author           = "Jerod Santo"
  s.email            = 'jerod.santo@gmail.com'
  s.homepage         = 'http://github.com/sant0sk1/hoster'
  s.require_path     = 'lib'
  s.autorequire      = 'hoster'
  s.executables      = ["hoster"]
  s.files            = ["README.md", "bin/hoster", "lib/hoster/hosts.rb", "lib/hoster.rb"]
  s.test_files       = ["test/test_helper.rb", "test/test_hoster.rb"]
  s.has_rdoc         = false
end
