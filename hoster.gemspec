Gem::Specification.new do |s|
  s.name = %q{hoster}
  s.version = "0.1"
  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Jerod Santo"]
  s.autorequire = %q{hoster}
  s.date = %q{2008-09-19}
  s.default_executable = %q{hoster}
  s.description = %q{Allows you to easily modify your local hosts file using one simple command}
  s.email = %q{jerod.santo@gmail.com}
  s.executables = ["hosert"]
  s.extra_rdoc_files = ["README.md"]
  s.files = ["README.md", "bin/hoster", "lib/hoster/hosts.rb", "lib/hoster.rb"]
  s.test_files = ["test/test_helper.rb", "test/test_hoster.rb"]
  s.has_rdoc = false
  s.homepage = %q{http://github.com/sant0sk1/hoster}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.2.0}
  s.summary = %q{Allows you to easily modify your local hosts file using one simple command}
end